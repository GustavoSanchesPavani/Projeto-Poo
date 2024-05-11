<%@ page import="java.sql.*, java.io.*, java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>

<%
    // Supondo que voc� tenha uma sess�o Java chamada session e j� tenha o ID do usu�rio l�
    int usuarioID = (int) session.getAttribute("idUsuario");

    // Supondo que voc� j� obteve o texto da observa��o do campo HTML, armazenado em uma vari�vel chamada observacaoTexto
    String observacaoTexto = request.getParameter("observacaoInput");

    try {
        // Conex�o com o banco de dados
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/soldiers?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");

        // Preparando a declara��o SQL para inser��o
        String query = "INSERT INTO solicitar_observacao (id_usuario_solicitante, data_solicitacao, status_solicitacao, texto) VALUES (?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(query);

        // Definindo os valores para a declara��o preparada
        pstmt.setInt(1, usuarioID);

        // Obtendo a data e hora atual
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedDateTime = now.format(formatter);
        pstmt.setString(2, formattedDateTime);

        // Definindo o status como "pendente"
        pstmt.setString(3, "pendente");

        // Definindo o texto da observa��o
        pstmt.setString(4, observacaoTexto);

        // Executando a inser��o
        int rowsAffected = pstmt.executeUpdate();

        // Fechando a conex�o
        pstmt.close();
        conn.close();

        // Verifica se a inser��o foi bem-sucedida
        if (rowsAffected > 0) {
            // Inser��o bem-sucedida, redireciona de volta para painel.jsp
            response.sendRedirect("painel.jsp");
        } else {
            // Inser��o falhou, exibe uma mensagem de erro para o usu�rio
            out.println("Erro ao inserir observa��o. Por favor, tente novamente.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        // Lidar com exce��es (por exemplo, logar o erro, exibir uma mensagem de erro para o usu�rio, etc.)
        out.println("Erro ao processar a solicita��o. Por favor, tente novamente mais tarde.");
    }
%>
