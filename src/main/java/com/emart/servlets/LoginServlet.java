package com.emart.servlets;

import com.emart.dataobject.UserDao;
import com.emart.entities.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            //exception handling
            try {
                //get data from login form
                String email = request.getParameter("email");
                String password = request.getParameter("password");

                //condition for chacking email and password empty or not
                if (email.isBlank() || password.isBlank()) {

                    //error message for empty email or password
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("msg", "Email or password cannot be empty..!");
                    httpSession.setAttribute("color", "danger");
                    response.sendRedirect("login.jsp");

                } else {

                    //call user dao login method for login tha user
                    List<User> userList = new UserDao().loginUserWithEmailAndPassword(email, password);

                    //condition for checking user exist or not
                    if (userList.isEmpty()) {

                        //user does not exist message
                        HttpSession httpSession = request.getSession();
                        httpSession.setAttribute("msg", "Email or Password invalid..!!");
                        httpSession.setAttribute("color", "danger");
                        response.sendRedirect("login.jsp");

                    } else {

                        User user = userList.get(0);

                        //create user session when user is present
                        HttpSession session = request.getSession();
                        session.setAttribute("currentUser", user);

                        //checking logged in user is admin or not if yes then open admin panel
                        if (user.getUserType().equalsIgnoreCase("admin")) {
                            response.sendRedirect("admin.jsp");

                            //if user is not admin then open home page
                        } else if (user.getUserType().equalsIgnoreCase("normal")) {
                            response.sendRedirect("home.jsp");

                        } else {

                            //when user type can not be find out (nither admin nor normal)
                            HttpSession httpSession = request.getSession();
                            httpSession.setAttribute("msg", "Internal error, user type not specified..!!");
                            httpSession.setAttribute("color", "danger");
                            response.sendRedirect("login.jsp");
                        }
                    }
                }
            } catch (Exception e) {

                e.printStackTrace();

                //if any exception is occured during login
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("msg", "Something went wrong, try again..!");
                httpSession.setAttribute("color", "danger");
                response.sendRedirect("login.jsp");
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
