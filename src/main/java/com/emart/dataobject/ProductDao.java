package com.emart.dataobject;

import com.emart.entities.Product;
import com.emart.helper.FactoryProvider;
import java.util.List;
import javax.persistence.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class ProductDao {

    //get session factory
    private SessionFactory factory = FactoryProvider.getFactory();

    //method for save new product
    public int saveProduct(SessionFactory factory, Product product) {

        Session session = factory.openSession();
        Transaction tx = session.beginTransaction();

        int id = (int) session.save(product);

        tx.commit();
        session.close();

        return id;
    }

    //method for get all product
    public List<Product> getAllProduct() {

        Session session = this.factory.openSession();

        Query query = session.createQuery("from Product");
        List<Product> products = query.getResultList();

        session.close();

        return products;
    }

    //method for getting single product by product id
    public Product getProductById(int pId) {

        Session session = this.factory.openSession();

        Product product = session.get(Product.class, pId);

        session.close();

        return product;
    }

    //method for getting all product of a particular category
    public List<Product> getAllProductByCId(int cId) {
        List<Product> products = null;
        try {
            Session session = this.factory.openSession();

            Query query = session.createQuery("from Product p where p.category.id=:x");

            query.setParameter("x", cId);

            products = query.getResultList();

        } catch (Exception e) {

            e.printStackTrace();

        }
        return products;
    }
}
