package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SendNotification
 */
@WebServlet("/SendNotification")
public class SendNotification extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
		response.setContentType("text/event-stream, charset=UTF-8");
        PrintWriter pw = response.getWriter();
        int i=0;
        
		int numResults = 0;

		Connection conn = null;		
		Statement sqlSearch = null;
		ResultSet resultsSearch = null;
        
		Class.forName("com.mysql.jdbc.Driver");  
		conn = DriverManager.getConnection("jdbc:mysql://google/fff"
				+ "?cloudSqlInstance=filmfriendfinder:us-central1:fff-db"
				+ "&socketFactory=com.google.cloud.sql.mysql.SocketFactory"
				+ "&useSSL=false"
				+ "&user=root"
				+ "&password=root");
		
		sqlSearch = conn.createStatement();
		String sql = "SELECT COUNT(*) FROM Project;";
		resultsSearch = sqlSearch.executeQuery(sql);
		
		if (resultsSearch.next()) {
			numResults = resultsSearch.getInt(1);
		}
		        
        while(true)
        {	
        	int newNum = 0;
    		Statement sqlCheck = conn.createStatement();
    		String check = "SELECT COUNT(*) FROM Project;";
    		ResultSet resultsCheck = sqlCheck.executeQuery(check);
    		
    		if (resultsCheck.next()) {
    			newNum = resultsCheck.getInt(1);
    		}

            if (newNum > numResults) {
	            pw.write("event: New Project Created\n\n");
	            pw.write("data: "+ "A new project has been created. Go check it out!" + "\n\n");
	            pw.flush();
	            response.flushBuffer();
	            numResults = newNum;
            }
	            
	            try {
	            	Thread.sleep(20000);
	            } catch (InterruptedException ie) {
	            	ie.printStackTrace();
	            }

        }
    }catch(Exception e){
        //e.printStackTrace();
    }
	}
}
