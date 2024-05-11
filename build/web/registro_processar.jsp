<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
// Obter par�metros do formul�rio
String nome = request.getParameter("nome");
int idade = Integer.parseInt(request.getParameter("cd_idade"));
String dataNascimento = request.getParameter("dt_dataNascimento");
String nomeGuerra = request.getParameter("nm_guerra");
String nomePatente = request.getParameter("nm_patente");
String nomeUsuario = request.getParameter("nm_usuarioLogin");
String senha = request.getParameter("senha");

try {
    // Carregar o driver JDBC
    Class.forName("com.mysql.cj.jdbc.Driver");
    
    // Estabelecer a conex�o com o banco de dados
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/soldiers?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
    
    // Verificar se o nome de usu�rio j� est� em uso
    String verificaUsuario = "SELECT * FROM usuario WHERE nm_usuarioLogin=?";
    PreparedStatement ps = conn.prepareStatement(verificaUsuario);
    ps.setString(1, nomeUsuario);
    ResultSet rs = ps.executeQuery();
    
    if (rs.next()) {
%>
        <script>
            alert("Nome de usu�rio j� est� em uso. Escolha outro.");
            window.location.href = "registro.jsp"; // Redirecionar de volta para registro.jsp
        </script>
<%
    } else {
        // Inserir novo usu�rio no banco de dados
        String inserirUsuario = "INSERT INTO usuario (nm_usuario,cd_idade,dt_dataNascimento,nm_guerra,nm_patente,nm_usuarioLogin,cd_senha) VALUES (?, ?, ?, ?, ?, ?,md5(?))";
        ps = conn.prepareStatement(inserirUsuario);
        ps.setString(1, nome);
        ps.setInt(2, idade);
        ps.setString(3, dataNascimento);
        ps.setString(4, nomeGuerra);
        ps.setString(5, nomePatente);
        ps.setString(6, nomeUsuario);
        ps.setString(7, senha);

        ps.executeUpdate();
        // Ap�s o registro bem-sucedido, redirecionar para a p�gina de login
        response.sendRedirect("index.jsp");
    }
    
    // Fechar recursos
    rs.close();
    ps.close();
    conn.close();
} catch (Exception e) {
    // Tratar exce��es, se ocorrerem
    out.println("Erro: " + e.getMessage());
}
%>
