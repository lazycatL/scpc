package com.project.base.dao.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Set;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.project.base.dao.BaseDao;
import com.project.commonModel.util.DateUtil;
import com.project.util.GenericsUtils;
import com.project.util.WebUtils;

@SuppressWarnings("unchecked")
public class BaseDaoImpl<T> extends HibernateDaoSupport implements BaseDao<T> {
	protected Class<T> entityClass = GenericsUtils.getSuperClassGenricType(this.getClass());

	public List findObjectByPar(Class clazz, String propName, Object propValue) {
		// TODO Auto-generated method stub
		Criteria c = this.getSession().createCriteria(clazz);
		if (propName != null) {
			c.add(Restrictions.eq(propName, propValue));
		}

		return c.list();
	}

	public List findObjectByPars(Class clazz, String[] propNames, Object[] propValues) {
		// TODO Auto-generated method stub
		Criteria c = this.getSession().createCriteria(clazz);
		for (int i = 0; i < propNames.length; i++) {
			c.add(Restrictions.eq(propNames[i], propValues[i]));
		}
		return c.list();
	}

	public void remove(Object obj) {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(obj);
	}

	public Long selectMaxIdFromTable(Class clazz, String propertyName) {
		Criteria c = this.getSession().createCriteria(clazz);
		c.setProjection(Projections.projectionList().add(Projections.max(propertyName)));
		Object ob = c.uniqueResult();
		Long orderMax = Long.parseLong(WebUtils.getRandomId());
		if (ob != null) {
			orderMax = Long.parseLong(ob.toString());
		}
		return orderMax;
	}

	public Long selectSequence() {
		Object object = this.getSession().createSQLQuery("select seq_number.nextval from dual").uniqueResult();

		return Long.parseLong(object.toString());
	}

	public Object save(Object obj, Class clazz, String key) {
		// TODO Auto-generated method stub
		BeanWrapper bw = new BeanWrapperImpl(obj);
		Object provalue = bw.getPropertyValue(key);
		if (provalue == null || provalue.equals("")) {
			// Long id=this.selectMaxIdFromTable(clazz, key)+1;
			// selectSequence();
			Long id = Long.parseLong(DateUtil.getDateToStringFull2(new Date()) + selectSequence());
			// String id=DateUtil.getDateToStringFull2(new
			// Date())+System.currentTimeMillis()+DateUtil.getRandom(1000,9999);
			bw.setPropertyValue(key, id.toString());
			this.getHibernateTemplate().save(obj);
			// this.getHibernateTemplate().flush();
		} else {
			getHibernateTemplate().merge(obj);
			// getHibernateTemplate().flush();
		}
		return obj;
	}

	public List findObjectByParOrder(Class clazz, String propName, Object propValue, String orderName, String ascoOrdesc) {
		// TODO Auto-generated method stub
		Criteria c = this.getSession().createCriteria(clazz);
		c.add(Restrictions.eq(propName, propValue));
		if (orderName != null && ascoOrdesc.equals("desc")) {
			c.addOrder(Order.desc(orderName));
		} else if (orderName != null && ascoOrdesc.equals("asc")) {
			c.addOrder(Order.asc(orderName));
		}
		return c.list();
	}

	public List findObjectByLikeParsOrder(Class clazz, String[] propNames, Object[] propValues, String[] orderNames, String[] ascoOrdescs) {
		// TODO Auto-generated method stub
		Criteria c = this.getSession().createCriteria(clazz);
		for (int i = 0; i < propNames.length; i++) {
			if (propValues[i].toString().length() > 0) {
				c.add(Restrictions.ilike(propNames[i], propValues[i].toString(), MatchMode.ANYWHERE));
			}

		}
		for (int i = 0; i < orderNames.length; i++) {
			String orderName = orderNames[i];
			String ascoOrdesc = ascoOrdescs[i];
			if (orderName != null && ascoOrdesc.equals("desc")) {
				c.addOrder(Order.desc(orderName));
			} else if (orderName != null && ascoOrdesc.equals("asc")) {
				c.addOrder(Order.asc(orderName));
			}
		}
		return c.list();
	}

	public List findObjectByParsOrder(Class clazz, String[] propNames, Object[] propValues, String orderName, String ascoOrdesc) {
		// TODO Auto-generated method stub
		Criteria c = this.getSession().createCriteria(clazz);
		for (int i = 0; i < propNames.length; i++) {
			c.add(Restrictions.eq(propNames[i], propValues[i]));
		}
		if (orderName != null && ascoOrdesc.equals("desc")) {
			c.addOrder(Order.desc(orderName));
		} else if (orderName != null && ascoOrdesc.equals("asc")) {
			c.addOrder(Order.asc(orderName));
		}
		return c.list();
	}

	public List findObjectListByParamAndOrder(Class clazz, LinkedHashMap proMap, LinkedHashMap orderMap) {
		// TODO Auto-generated method stub
		Criteria c = this.getSession().createCriteria(clazz);
		if (proMap != null) {
			Set set = proMap.keySet();
			Iterator it = set.iterator();
			while (it.hasNext()) {
				Object obkey = it.next();
				Object obvalue = proMap.get(obkey);
				c.add(Restrictions.eq(obkey.toString(), obvalue));
			}
		}
		if (orderMap != null) {
			Set set1 = orderMap.keySet();
			Iterator it1 = set1.iterator();
			while (it1.hasNext()) {
				Object obkey = it1.next();
				Object obvalue = orderMap.get(obkey);
				if (obvalue != null && obvalue.equals("desc")) {
					c.addOrder(Order.desc(obkey.toString()));
				} else if (obvalue != null && obvalue.equals("asc")) {
					c.addOrder(Order.asc(obkey.toString()));
				}
			}
		}
		return c.list();
	}

	public Long getUniqueId() {
		Long id = Long.parseLong(DateUtil.getDateToStringFull2(new Date()) + selectSequence());
		return id;
	}

	public Criteria getCriteria(Class clazz) {
		Criteria c = this.getSession().createCriteria(clazz);
		return c;
	}


	/**
	 * 分页查询函数，使用已设好查询条件与排序的<code>Criteria</code>.
	 * 
	 * @param pageNo
	 *            页号,从1开始.
	 * @return 含总记录数和当前页数据的Page对象.
	 */

	public void clear() {
		getSession().clear();
	}

	public void delete(Serializable... entityids) {
		for (Serializable entityid : entityids) {
			getSession().delete(getSession().load(this.entityClass, entityid));
		}
	}

	public T find(Serializable entityId) {
		if (entityId == null) {
			return null;
		}
		return (T) getSession().get(this.entityClass, entityId);
	}

	public long getCount() {
		return ((Number) getSession().createQuery(//
				"SELECT count(o) FROM " + getEntityName(entityClass) + " o")//
				.uniqueResult()).longValue();
	}

	public Serializable save(Object entity) {
		return getSession().save(entity);

	}

	public void update(Object entity) {
		getSession().update(entity);
	}

	public void saveOrUpdateEntity(T t) {
		getSession().saveOrUpdate(t);
	}

	public List<T> findAll() {
		return getSession().createQuery(//
				"FROM " + getEntityName(entityClass))//
				.list();
	}


	public List<T> findEntityByHQL(String hql, Serializable... serializables) {
		Query query = getSession().createQuery(hql);
		setQueryParams(query, serializables);
		return query.list();
	}

	public T findUniqueResult(String hql, Serializable... serializables) {
		Query query = getSession().createQuery(hql);
		setQueryParams(query, serializables);
		return (T) query.uniqueResult();
	}

	public void batchHandle(String hql, Serializable... serializables) {
		Query query = getSession().createQuery(hql);
		setQueryParams(query, serializables);
		query.executeUpdate();
	}

	protected static void setQueryParams(Query query, Object[] queryParams) {
		if (queryParams != null && queryParams.length > 0) {
			for (int i = 0; i < queryParams.length; i++) {
				query.setParameter(i, queryParams[i]);
			}
		}
	}

	protected static String buildOrderby(LinkedHashMap<String, String> orderby) {
		StringBuffer orderbyql = new StringBuffer("");
		if (orderby != null && orderby.size() > 0) {
			orderbyql.append(" order by ");
			for (String key : orderby.keySet()) {
				orderbyql.append("o.").append(key).append(" ").append(orderby.get(key)).append(",");
			}
			orderbyql.deleteCharAt(orderbyql.length() - 1);
		}
		return orderbyql.toString();
	}

	protected static <E> String getEntityName(Class<E> clazz) {
		String entityname = clazz.getSimpleName();
		return entityname;
	}



}
