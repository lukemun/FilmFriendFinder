import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonToken;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * Servlet implementation class Sort
 */
@WebServlet("/Sort")
public class Sort extends HttpServlet {
	public static final String CREDENTIALS_STRING = "jdbc:mysql://google/test?cloudSqlInstance=csci201lab7-255501:us-central1:lab8&socke" + 
    		"tFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=Jason" + 
    		"&password=password";
    static Connection connection = null;
	private static final long serialVersionUID = 1L;
	ResultSet rs;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Sort() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	protected void service (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String genre = request.getParameter("genre");
		String Date = request.getParameter("date");
		String popularity = request.getParameter("popularity");
		String d_asc;
		String p_asc;
		List<Post> items = new ArrayList<Post>();
		GsonBuilder builder = new GsonBuilder();
		builder.setPrettyPrinting();
		Gson gson = builder.create();
		//Formats the date from SQL
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Posts posts = new Posts();
		if(Date.equals("newest")) {d_asc = "DESC";}
		else {d_asc = "ASC";}
		if(popularity.equals("highest")) {p_asc = "DESC";}
		else {p_asc = "ASC";}
		try {
			PreparedStatement ps = connection.prepareStatement("SELECT * FROM Project WHERE tag=? ORDER BY time ?, rating ?");
			ps.setString(1, genre);
			ps.setString(2, d_asc);
			ps.setString(3, p_asc);
			rs = ps.executeQuery();
			while(rs.next()) {
				String title = rs.getString("title"); String tag = rs.getString("tag"); String time = sdf.format(rs.getTimestamp("time")); String summary = rs.getString("summary");
				int rating = rs.getInt("rating");
				items.add(new Post(title, tag, time, rating, summary));				
			}
			posts.items = items.toArray(new Post[items.size()]);
			String json = gson.toJson(posts);
			session.setAttribute("data", json);
			RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/Projects.jsp");
	        dispatch.forward(request, response);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
class Posts{
	Post [] items;
	
}
class Post{ 
	String title;
	String tag;
	String time; 
	int rating; 
	String summary;
	Post(String title, String tag, String time, int Rating, String summary){
		this.title = title;
		this.tag = tag;
		this.time = time; 
		this.rating = Rating;
		this.summary = summary;
	}
}
