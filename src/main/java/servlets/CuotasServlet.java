package servlets;

import conexion.Conexion;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class CuotasServlet extends HttpServlet {

    // ── GET → listar cuotas ──────────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Conexion cn = new Conexion();
        Connection con = cn.conectar();

        try {
            CallableStatement cs = con.prepareCall("{CALL sp_listar_cuotas()}");
            ResultSet rs = cs.executeQuery();

            // Convertir ResultSet a lista ANTES de cerrar la conexión
            List<Map<String, Object>> lista = new ArrayList<>();
            while (rs.next()) {
                Map<String, Object> fila = new HashMap<>();
                fila.put("id_cuota",     rs.getInt("id_cuota"));
                fila.put("id_prestamo",  rs.getInt("id_prestamo"));
                fila.put("numero_cuota", rs.getInt("numero_cuota"));
                fila.put("monto_cuota",  rs.getDouble("monto_cuota"));
                fila.put("fecha_pago",   rs.getString("fecha_pago"));
                fila.put("estado",       rs.getString("estado"));
                lista.add(fila);
            }

            request.setAttribute("listaCuotas", lista);
            request.getRequestDispatcher("cuotas.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Error al listar cuotas: " + e.getMessage(), e);
        } finally {
            cerrarConexion(con);
        }
    }

    // ── POST → registrar pago de cuota ───────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String idCuotaStr   = request.getParameter("id_cuota");
        String fechaPagoStr = request.getParameter("fecha_pago");

        if (idCuotaStr == null || idCuotaStr.trim().isEmpty()) {
            request.setAttribute("error", "Debe indicar el ID de la cuota.");
            request.getRequestDispatcher("CuotasServlet").forward(request, response);
            return;
        }

        Conexion cn = new Conexion();
        Connection con = cn.conectar();

        try {
            int  idCuota   = Integer.parseInt(idCuotaStr);
            Date fechaPago = (fechaPagoStr != null && !fechaPagoStr.isEmpty())
                             ? Date.valueOf(fechaPagoStr)
                             : Date.valueOf(LocalDate.now());

            CallableStatement cs = con.prepareCall("{CALL sp_pagar_cuota(?, ?)}");
            cs.setInt (1, idCuota);
            cs.setDate(2, fechaPago);
            cs.executeUpdate();

            response.sendRedirect("CuotasServlet");

        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de cuota no válido.");
            request.getRequestDispatcher("CuotasServlet").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error al pagar cuota: " + e.getMessage(), e);
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
