
import java.io.*;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SendMail
 * @param <PrintWriter>
 */
@WebServlet("/SendMail")
public class SendMail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String to = request.getParameter("to");
        String subject = request.getParameter("subject");
        String message =  request.getParameter("message");
        String user = request.getParameter("user");
        String pass = request.getParameter("pass");
		send(to, subject, message, user, pass);
        out.println("We have received your feedback!");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	public static void send(String to, String sub,
							String msg, final String user,final String pass)
	{
		//create an instance of Properties Class
		Properties props = new Properties();

        /*  Specifies the IP address of your default mail server
     	    for e.g if you are using gmail server as an email server
            you will pass smtp.gmail.com as value of mail.smtp host.
            As shown here in the code.
            Change accordingly, if your email id is not a gmail id
        */
		props.put("mail.smtp.auth", true);
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.qq.com");
		props.put("mail.smtp.port", 587);
		props.put("mail.smtp.ssl.trust", "smtp.qq.com");
        /* Pass Properties object(props) and Authenticator object
           for authentication to Session instance
        */
		Session session = Session.getInstance(props,new Authenticator()
		{
			protected PasswordAuthentication getPasswordAuthentication()
			{
				return new PasswordAuthentication(user,pass);
			}
		});
		try {
     	      /*  Create an instance of MimeMessage,
     	          it accept MIME types and headers
     	      */
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(user));
			message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));
			message.setSubject(sub);
			message.setText(msg);
			/* Transport class is used to deliver the message to the recipients */
			Transport.send(message);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
}
