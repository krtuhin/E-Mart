package com.emart.servlets;

import com.emart.dataobject.CategoryDao;
import com.emart.entities.Category;
import com.emart.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AddCategoryServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            //custom try catch
            try {
                //fetch data from html form
                String name = request.getParameter("name");
                String description = request.getParameter("description");

                //condition for checking name and description is blank or not
                if (name.isBlank() || description.isBlank()) {

                    //if name or description is empty then send this message
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("msg", "Category name or description can't be empty!");
                    httpSession.setAttribute("color", "danger");
                    response.sendRedirect("admin.jsp");

                } else {

                    //save data to category object
                    Category category = new Category(name, description);

                    //save data into database
                    int id = new CategoryDao().saveCategory(FactoryProvider.getFactory(), category);

                    //success message for add category
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("msg", "Category added successfully..!");
                    httpSession.setAttribute("color", "success");
                    response.sendRedirect("admin.jsp");
                }
            } catch (Exception e) {

                //condition for checking category already exist or not
                if (e.toString().contains("ConstraintViolationException")) {

                    //failure message for duplicate category
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("msg", "Category already exist..! Try with another!");
                    httpSession.setAttribute("color", "danger");
                    response.sendRedirect("admin.jsp");

                } else {

                    //failure message for add category
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("msg", "Something went wrong..! Try again!");
                    httpSession.setAttribute("color", "danger");
                    response.sendRedirect("admin.jsp");

                }
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
