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


public class PrestamosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Conexion cn = new Conexion();
        Connection con = cn.conectar();

        try {
            // Lista de asociados para el combo del formulario
            CallableStatement csAsoc = con.prepareCall("{CALL sp_listar_asociados()}");
            ResultSet rsAsoc = csAsoc.executeQuery();
            List<Map<String, Object>> listaAsociados = new ArrayList<>();
            while (rsAsoc.next()) {
                Map<String, Object> fila = new HashMap<>();
                fila.put("id_asociado", rsAsoc.getInt("id_asociado"));
                fila.put("nombres",     rsAsoc.getString("nombres"));
                fila.put("apellidos",   rsAsoc.getString("apellidos"));
                listaAsociados.add(fila);
            }
            request.setAttribute("listaAsociados", listaAsociados);

            // Lista de préstamos — sp_listar_prestamos devuelve columna "asociado" (CONCAT)
            CallableStatement csPrest = con.prepareCall("{CALL sp_listar_prestamos()}");
            ResultSet rsPrest = csPrest.executeQuery();
            List<Map<String, Object>> listaPrestamos = new ArrayList<>();
            while (rsPrest.next()) {
                Map<String, Object> fila = new HashMap<>();
                fila.put("id_prestamo",     rsPrest.getInt("id_prestamo"));
                fila.put("asociado",        rsPrest.getString("asociado")); // columna correcta
                fila.put("monto",           rsPrest.getDouble("monto"));
                fila.put("interes",         rsPrest.getDouble("interes"));
                fila.put("cantidad_cuotas", rsPrest.getInt("cantidad_cuotas"));
                fila.put("fecha",           rsPrest.getString("fecha"));
                fila.put("estado",          rsPrest.getString("estado"));
                listaPrestamos.add(fila);
            }
            request.setAttribute("listaPrestamos", listaPrestamos);

            request.getRequestDispatcher("prestamos.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Error al listar préstamos: " + e.getMessage(), e);
        } finally {
            cerrarConexion(con);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String idAsociadoStr     = request.getParameter("id_asociado");
        String montoStr          = request.getParameter("monto");
        String interesStr        = request.getParameter("interes");
        String cantidadCuotasStr = request.getParameter("cuotas");
        String fecha             = request.getParameter("fecha");
        String estado            = request.getParameter("estado");

        if (montoStr == null || montoStr.trim().isEmpty()) {
            request.setAttribute("error", "El monto es obligatorio.");
            request.getRequestDispatcher("PrestamosServlet").forward(request, response);
            return;
        }

        Conexion cn = new Conexion();
        Connection con = cn.conectar();

        try {
            int    idAsociado     = Integer.parseInt(idAsociadoStr);
            double monto          = Double.parseDouble(montoStr);
            double interes        = Double.parseDouble(interesStr);
            int    cantidadCuotas = Integer.parseInt(cantidadCuotasStr);

            CallableStatement cs = con.prepareCall("{CALL sp_insertar_prestamo(?, ?, ?, ?, ?, ?)}");
            cs.setInt   (1, idAsociado);
            cs.setDouble(2, monto);
            cs.setDouble(3, interes);
            cs.setInt   (4, cantidadCuotas);
            cs.setString(5, fecha);
            cs.setString(6, estado != null ? estado : "Pendiente");
            cs.executeUpdate();

            response.sendRedirect("PrestamosServlet");

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Los valores numéricos ingresados no son válidos.");
            request.getRequestDispatcher("PrestamosServlet").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error al insertar préstamo: " + e.getMessage(), e);
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
