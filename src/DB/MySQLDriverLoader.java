package DB;

import javax.servlet.http.HttpServlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;

public class MySQLDriverLoader extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void init(ServletConfig config) throws ServletException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch(Exception ex) {
            throw new ServletException(ex);
        }
    }
}
