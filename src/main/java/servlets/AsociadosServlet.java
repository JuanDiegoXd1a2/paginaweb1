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


public class AsociadosServlet extends HttpServlet {

    // ── GET → listar asociados ───────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Conexion cn = new Conexion();
        Connection con = cn.conectar();

        try {
            CallableStatement cs = con.prepareCall("{CALL sp_listar_asociados()}");
            ResultSet rs = cs.executeQuery();

            // Convertir ResultSet a lista ANTES de cerrar la conexión
            List<Map<String, Object>> lista = new ArrayList<>();
            while (rs.next()) {
                Map<String, Object> fila = new HashMap<>();
                fila.put("id_asociado", rs.getInt("id_asociado"));
                fila.put("dni",         rs.getString("dni"));
                fila.put("nombres",     rs.getString("nombres"));
                fila.put("apellidos",   rs.getString("apellidos"));
                fila.put("telefono",    rs.getString("telefono"));
                fila.put("direccion",   rs.getString("direccion"));
                fila.put("correo",      rs.getString("correo"));
                lista.add(fila);
            }

            request.setAttribute("listaAsociados", lista);
            request.getRequestDispatcher("asociados.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Error al listar asociados: " + e.getMessage(), e);
        } finally {
            cerrarConexion(con);
        }
    }

    // ── POST → insertar asociado ─────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String dni       = request.getParameter("dni");
        String nombres   = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String telefono  = request.getParameter("telefono");
        String direccion = request.getParameter("direccion");
        String correo    = request.getParameter("correo");

        if (dni == null || dni.trim().isEmpty()) {
            request.setAttribute("error", "El DNI es obligatorio.");
            request.getRequestDispatcher("AsociadosServlet").forward(request, response);
            return;
        }

        Conexion cn = new Conexion();
        Connection con = cn.conectar();

        try {
            CallableStatement cs = con.prepareCall(
                "{CALL sp_insertar_asociado(?, ?, ?, ?, ?, ?)}"
            );
            cs.setString(1, dni.trim());
            cs.setString(2, nombres   != null ? nombres.trim()   : "");
            cs.setString(3, apellidos != null ? apellidos.trim() : "");
            cs.setString(4, telefono  != null ? telefono.trim()  : "");
            cs.setString(5, direccion != null ? direccion.trim() : "");
            cs.setString(6, correo    != null ? correo.trim()    : "");

            cs.executeUpdate();

            response.sendRedirect("AsociadosServlet");

        } catch (SQLIntegrityConstraintViolationException e) {
            request.setAttribute("error", "El DNI ingresado ya existe.");
            request.getRequestDispatcher("AsociadosServlet").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error al insertar asociado: " + e.getMessage(), e);
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
