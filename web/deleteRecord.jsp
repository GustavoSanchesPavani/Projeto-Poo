<%@ page import="java.sql.*" %>

<%
try {
    // Carregando o driver JDBC e estabelecendo a conex�o com o banco de dados
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/soldiers?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");

    // Verifica se a requisi��o cont�m um ID de registro
    int idEscala = Integer.parseInt(request.getParameter("idEscala"));
    if (idEscala != 0) {
        // Primeiro, busca os dados da tabela escala_guarda e registro_entrada_saida
        String selectQuery = "SELECT eg.id_usuario, re.data_hora_entrada, re.data_hora_saida, eg.tipo_escala, eg.corte_cabelo_conformidade, eg.identificacao_militar_conformidade FROM escala_guarda eg JOIN registro_entrada_saida re ON eg.id_usuario = re.id_usuario WHERE eg.id_usuario = ?";
        PreparedStatement selectStatement = conn.prepareStatement(selectQuery);
        selectStatement.setInt(1, idEscala);
        ResultSet rs = selectStatement.executeQuery();
        
        if (rs.next()) {
            // Obt�m os dados do registro
            int idUsuario = rs.getInt("id_usuario");
            String dataHoraEntrada = rs.getString("data_hora_entrada");
            String dataHoraSaida = rs.getString("data_hora_saida");
            String tipoEscala = rs.getString("tipo_escala");
            boolean corteCabeloConformidade = rs.getBoolean("corte_cabelo_conformidade");
            boolean identificacaoMilitarConformidade = rs.getBoolean("identificacao_militar_conformidade");
            
            // Insere o registro na tabela de hist�rico
            String insertQuery = "INSERT INTO historico_escala_guarda (id_usuario, data_hora_entrada, data_hora_saida, tipo_escala, corte_cabelo_conformidade, identificacao_militar_conformidade, data_remocao) VALUES (?, ?, ?, ?, ?, ?, NOW())";
            PreparedStatement insertStatement = conn.prepareStatement(insertQuery);
            insertStatement.setInt(1, idUsuario);
            insertStatement.setString(2, dataHoraEntrada);
            insertStatement.setString(3, dataHoraSaida);
            insertStatement.setString(4, tipoEscala);
            insertStatement.setBoolean(5, corteCabeloConformidade);
            insertStatement.setBoolean(6, identificacaoMilitarConformidade);
            
            int rowsInserted = insertStatement.executeUpdate();
            insertStatement.close();

            // Verifica se o registro foi inserido com sucesso na tabela de hist�rico
            if (rowsInserted > 0) {
                // Executa a exclus�o do registro na tabela principal ap�s a inser��o no hist�rico
                String deleteEscalaQuery = "DELETE FROM escala_guarda WHERE id_usuario = ?";
                PreparedStatement deleteEscalaStatement = conn.prepareStatement(deleteEscalaQuery);
                deleteEscalaStatement.setInt(1, idUsuario);
                
                int rowsDeletedEscala = deleteEscalaStatement.executeUpdate();
                deleteEscalaStatement.close();

                // Verifica se o registro foi exclu�do com sucesso da tabela escala_guarda
                if (rowsDeletedEscala > 0) {
                    // Exclui o registro da tabela registro_entrada_saida
                    String deleteRegistroQuery = "DELETE FROM registro_entrada_saida WHERE id_usuario = ?";
                    PreparedStatement deleteRegistroStatement = conn.prepareStatement(deleteRegistroQuery);
                    deleteRegistroStatement.setInt(1, idUsuario);
                    
                    int rowsDeletedRegistro = deleteRegistroStatement.executeUpdate();
                    deleteRegistroStatement.close();

                    // Verifica se o registro foi exclu�do com sucesso da tabela registro_entrada_saida
                    if (rowsDeletedRegistro > 0) {
                        // Redireciona para a p�gina principal ap�s a exclus�o
                        response.sendRedirect("painel.jsp");
                    } else {
                        // Se o registro n�o foi exclu�do da tabela registro_entrada_saida, exibe uma mensagem de erro
                        %>
                        <script>
                            alert("Falha ao excluir o registro da tabela registro_entrada_saida.");
                            window.location.href = "painel.jsp";
                        </script>
                        <%
                    }
                } else {
                    // Se o registro n�o foi exclu�do da tabela escala_guarda, exibe uma mensagem de erro
                    %>
                    <script>
                        alert("Falha ao excluir o registro da tabela escala_guarda.");
                        window.location.href = "painel.jsp";
                    </script>
                    <%
                }
            } else {
                // Se o registro n�o foi inserido na tabela de hist�rico, exibe uma mensagem de erro
                %>
                <script>
                    alert("Falha ao inserir o registro na tabela de hist�rico.");
                    window.location.href = "painel.jsp";
                </script>
                <%
            }
        } else {
            // Se n�o encontrar o registro, exibe uma mensagem de erro
            %>
            <script>
                alert("Registro n�o encontrado.");
                window.location.href = "painel.jsp";
            </script>
            <%
        }
        rs.close();
        selectStatement.close();
    }
    // Fecha a conex�o com o banco de dados
    conn.close();
} catch (SQLException e) {
    // Exibe informa��es de erro em caso de exce��o de SQL
    e.printStackTrace();
    %>
    <script>
        alert("Ocorreu um erro no banco de dados: <%= e.getMessage() %>");
        window.location.href = "painel.jsp";
    </script>
    <%
} catch (ClassNotFoundException e) {
    // Exibe informa��es de erro em caso de exce��o de Classe n�o encontrada
    e.printStackTrace();
    %>
    <script>
        alert("Driver JDBC n�o encontrado: <%= e.getMessage() %>");
        window.location.href = "painel.jsp";
    </script>
    <%
}
%>

<a href="painel.jsp">Voltar para a lista</a>
