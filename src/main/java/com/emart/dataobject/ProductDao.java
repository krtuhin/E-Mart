package com.emart.dataobject;

import com.emart.entities.Product;
import java.util.List;
import javax.persistence.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class ProductDao {

    public int saveProduct(SessionFactory factory, Product product) {

        Session session = factory.openSession();
        Transaction tx = session.beginTransaction();

        int id = (int) session.save(product);

        tx.commit();
        session.close();

        return id;
    }

    public List<Product> getAllProduct(SessionFactory factory) {

        Session session = factory.openSession();

        Query query = session.createQuery("from Product");
        List<Product> products = query.getResultList();

        session.close();

        return products;
    }

    public Product getProductById(SessionFactory factory, int pId) {

        Session session = factory.openSession();

        Product product = session.get(Product.class, pId);

        session.close();

        return product;
    }

    public List<Product> getAllProductByCId(SessionFactory factory, int cId) {
        List<Product> products = null;
        try {
            Session session = factory.openSession();

            Query query = session.createQuery("from Product p where p.category.id=:x");

            query.setParameter("x", cId);

            products = query.getResultList();

        } catch (Exception e) {

            e.printStackTrace();

        }
        return products;
    }
}
