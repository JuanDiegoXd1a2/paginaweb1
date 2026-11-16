package servlets;

import conexion.Conexion;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class ReportesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Conexion cn = new Conexion();
        Connection con = cn.conectar();

        try {
            // Totales para las cards — sp_resumen_general devuelve total_asociados, total_prestamos, monto_total
            CallableStatement csResumen = con.prepareCall("{CALL sp_resumen_general()}");
            ResultSet rsResumen = csResumen.executeQuery();
            if (rsResumen.next()) {
                request.setAttribute("totalAsociados", rsResumen.getInt("total_asociados"));
                request.setAttribute("totalPrestamos", rsResumen.getInt("total_prestamos"));
                request.setAttribute("montoTotal",     rsResumen.getDouble("monto_total"));
            }

            // Tabla de préstamos — sp_reporte_prestamos devuelve columna "asociado" (CONCAT)
            CallableStatement csPrest = con.prepareCall("{CALL sp_reporte_prestamos()}");
            ResultSet rsPrest = csPrest.executeQuery();
            List<Map<String, Object>> listaPrestamos = new ArrayList<>();
            while (rsPrest.next()) {
                Map<String, Object> fila = new HashMap<>();
                fila.put("id_prestamo", rsPrest.getInt("id_prestamo"));
                fila.put("asociado",    rsPrest.getString("asociado")); // columna correcta
                fila.put("monto",       rsPrest.getDouble("monto"));
                fila.put("estado",      rsPrest.getString("estado"));
                listaPrestamos.add(fila);
            }
            request.setAttribute("listaPrestamos", listaPrestamos);

            request.getRequestDispatcher("reportes.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Error al generar reporte: " + e.getMessage(), e);
        } finally {
            cerrarConexion(con);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String dni    = request.getParameter("dni");
        String correo = request.getParameter("correo");

        if (dni == null || dni.trim().isEmpty()) {
            request.setAttribute("error", "El DNI es obligatorio para generar el historial.");
            request.getRequestDispatcher("reportes_reportes.jsp").forward(request, response);
            return;
        }

        Conexion cn = new Conexion();
        Connection con = cn.conectar();

        try {
            // sp_historial_por_dni devuelve: id_prestamo, asociado, dni, correo,
            //                                monto, interes, cantidad_cuotas, fecha, estado
            CallableStatement cs = con.prepareCall("{CALL sp_historial_por_dni(?, ?)}");
            cs.setString(1, dni.trim());
            cs.setString(2, correo != null ? correo.trim() : "");
            ResultSet rs = cs.executeQuery();

            List<Map<String, Object>> historial = new ArrayList<>();
            while (rs.next()) {
                Map<String, Object> fila = new HashMap<>();
                fila.put("id_prestamo",     rs.getInt("id_prestamo"));
                fila.put("asociado",        rs.getString("asociado")); // CONCAT nombres+apellidos
                fila.put("dni",             rs.getString("dni"));
                fila.put("monto",           rs.getDouble("monto"));
                fila.put("interes",         rs.getDouble("interes"));
                fila.put("cantidad_cuotas", rs.getInt("cantidad_cuotas"));
                fila.put("fecha",           rs.getString("fecha"));
                fila.put("estado",          rs.getString("estado"));
                historial.add(fila);
            }

            request.setAttribute("historial", historial);
            request.setAttribute("dniBuscado", dni.trim());

            request.getRequestDispatcher("resultados.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Error al generar historial: " + e.getMessage(), e);
        } finally {
            cerrarConexion(con);
        }
    }

    private void cerrarConexion(Connection con) {
        if (con != null) {
            try { con.close(); } catch (SQLException ignored) {}
        }
    }
}
