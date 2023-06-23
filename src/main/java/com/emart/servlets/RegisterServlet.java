package com.emart.servlets;

import com.emart.entities.User;
import com.emart.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class RegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            //own exception handling
            try {

                //chacking terms and condition
                String check = request.getParameter("check");

                if (check == null) {

                    //error message for terms and condition
                    HttpSession s = request.getSession();
                    s.setAttribute("msg", "Please accept terms & conditions and try again!!");
                    s.setAttribute("color", "warning");
                    response.sendRedirect("register.jsp");
                } else {

                    //accessing all the data from register form
                    String name = request.getParameter("name");
                    String email = request.getParameter("email");
                    String password = request.getParameter("password");
                    String phone = request.getParameter("phone");
                    String address = request.getParameter("address");

                    //calling user object
                    User user = new User(name, email, password, phone, "default.png", address);

                    //getting hibernate session
                    Session session = FactoryProvider.getFactory().openSession();

                    //create transaction
                    Transaction transaction = session.beginTransaction();

                    //saving user data into database
                    int userId = (int) session.save(user);

                    //commit transaction and close session
                    transaction.commit();
                    session.close();

                    //registration successfull message
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("msg", "Registered Successfully..!!");
                    httpSession.setAttribute("color", "success");
                    response.sendRedirect("register.jsp");
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();

                //user exist message
                if (e.toString().equalsIgnoreCase("javax.persistence.PersistenceException: org.hibernate.exception.ConstraintViolationException: could not execute statement")) {
                    HttpSession s = request.getSession();
                    s.setAttribute("msg", "Email already exist, try with another..!");
                    s.setAttribute("color", "danger");
                    response.sendRedirect("register.jsp");

                } else {

                    //all other exception message
                    HttpSession s = request.getSession();
                    s.setAttribute("msg", "Problem occured try again!!");
                    s.setAttribute("color", "danger");
                    response.sendRedirect("register.jsp");
                }
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
