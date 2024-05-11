<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>

<%
    // Recupere os par�metros enviados do formul�rio
    String idSolicitacao = request.getParameter("id_solicitacao");
    String acao = request.getParameter("acao");

    try {
        // Conex�o com o banco de dados
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/soldiers?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
        
        // Atualize o status da solicita��o com base na a��o
        String updateQuery = "";
        if (acao != null && idSolicitacao != null) {
            if (acao.equals("aceitar")) {
                updateQuery = "UPDATE solicitar_observacao SET status_solicitacao = 'Aceita' WHERE id_usuario_solicitante = ?";
            } else if (acao.equals("recusar")) {
                updateQuery = "UPDATE solicitar_observacao SET status_solicitacao = 'Recusada' WHERE id_usuario_solicitante = ?";
            }
            PreparedStatement pstmt = conn.prepareStatement(updateQuery);
            pstmt.setString(1, idSolicitacao);
            pstmt.executeUpdate();
            pstmt.close();
        }

        // Fechando a conex�o
        conn.close();
        
        // Redirecionar de volta para a p�gina anterior ou para uma p�gina de confirma��o
        response.sendRedirect("painel.jsp"); // Substitua "pagina_anterior.jsp" pela p�gina para onde deseja redirecionar
    } catch (Exception e) {
        e.printStackTrace();
        // Tratamento de erros, se necess�rio
    }
%>
