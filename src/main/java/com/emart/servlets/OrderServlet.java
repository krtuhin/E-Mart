package com.emart.servlets;

import com.emart.dataobject.OrderDao;
import com.emart.entities.Order;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class OrderServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            //custom try catch
            try {

                //data from payment page
                String paymentMode = request.getParameter("payment-mode");
                String userId = request.getParameter("user-id");
                String addressId = request.getParameter("address-id");
                String productId = request.getParameter("product-id");

                //store data into order class object
                Order order = new Order(userId, productId, addressId, paymentMode, new Date());

                //save data into database using dao class
                int id = new OrderDao().doOrder(order);

                //open http session
                HttpSession s = request.getSession();

                //id = 0 when order will not done
                if (id != 0) {

                    //if order successful then go order success page
                    response.sendRedirect("order_success_page.jsp?p_id=" + productId + "&a_id=" + addressId + "&o_id=" + id);

                } else {

                    //order failure message
                    s.setAttribute("msg", "Something went wrong in our side, please try again..!");
                    s.setAttribute("color", "danger");

                    response.sendRedirect("payment_page.jsp?p_id=" + productId + "&a_id=" + addressId);

                }
            } catch (Exception e) {

                //if any exception happen in server side
                HttpSession s = request.getSession();

                s.setAttribute("msg", "Something went wrong..!");
                s.setAttribute("color", "danger");

                response.sendRedirect("payment_page.jsp");
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
