package servlets;

import conexion.Conexion;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;


public class LoginServlet extends HttpServlet {

    // ── POST → validar credenciales ──────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String usuario = request.getParameter("usuario");
        String clave   = request.getParameter("clave");

        // Validación de campos vacíos
        if (usuario == null || usuario.trim().isEmpty()
                || clave == null || clave.trim().isEmpty()) {
            request.setAttribute("error", "Usuario y contraseña son obligatorios.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        Conexion cn = new Conexion();
        Connection con = cn.conectar();

        if (con == null) {
            request.setAttribute("error", "No se pudo conectar a la base de datos.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try {
            // sp_validar_usuario tiene un parámetro OUT p_acceso (TINYINT)
            CallableStatement cs = con.prepareCall("{CALL sp_validar_usuario(?, ?, ?)}");
            cs.setString(1, usuario.trim());
            cs.setString(2, clave.trim());
            cs.registerOutParameter(3, Types.TINYINT);

            cs.execute();

            int acceso = cs.getInt(3);  // 1 = OK, 0 = sin acceso

            if (acceso == 1) {
                // Crear sesión
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuario.trim());
                session.setMaxInactiveInterval(1800); // 30 min
                response.sendRedirect("Principal.jsp");
            } else {
                request.setAttribute("error", "Usuario o contraseña incorrectos.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            throw new ServletException("Error en el proceso de login: " + e.getMessage(), e);
        } finally {
            cerrarConexion(con);
        }
    }

    // ── GET → redirigir a login.jsp ─────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    // ── Util ─────────────────────────────────────────────────────────────────
    private void cerrarConexion(Connection con) {
        if (con != null) {
            try { con.close(); } catch (SQLException ignored) {}
        }
    }
}