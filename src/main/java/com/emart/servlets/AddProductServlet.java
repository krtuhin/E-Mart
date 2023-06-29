package com.emart.servlets;

import com.emart.dataobject.CategoryDao;
import com.emart.dataobject.ProductDao;
import com.emart.entities.Category;
import com.emart.entities.Product;
import com.emart.helper.FactoryProvider;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class AddProductServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            try {
                //getting data from add product modal form
                String name = request.getParameter("name");
                String description = request.getParameter("desc");
                int price = Integer.parseInt(request.getParameter("price"));
                int discount = Integer.parseInt(request.getParameter("discount"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                int cId = Integer.parseInt(request.getParameter("category"));
                Part image = request.getPart("photo");

                //getting name of submitted image
                String photo = image.getSubmittedFileName();

                //getting product category from category id
                Category c = new CategoryDao().getCategoryById(FactoryProvider.getFactory(), cId);

                //save data to product object
                Product product = new Product(name, description, price, photo, discount, quantity, c);

                //save data into database using product dao class
                int pId = new ProductDao().saveProduct(FactoryProvider.getFactory(), product);

                //start process of save image into server
                //path for submitted image
                String path = request.getRealPath("img") + File.separator + "products" + File.separator + photo;

                FileOutputStream fos = new FileOutputStream(path);

                InputStream inputStream = image.getInputStream();

                byte data[] = new byte[inputStream.available()];

                inputStream.read(data);

                fos.write(data);

                fos.flush();
                fos.close();
                inputStream.close();

                //end process of save image into server
                
                //add product successfull message
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("msg", "Product added successfully..!");
                httpSession.setAttribute("color", "success");
                response.sendRedirect("admin.jsp");

            } catch (Exception e) {

                e.printStackTrace();

                //message when any problem occured during save the product into database
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("msg", "Something went wrong, try again..!");
                httpSession.setAttribute("color", "danger");
                response.sendRedirect("admin.jsp");
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
