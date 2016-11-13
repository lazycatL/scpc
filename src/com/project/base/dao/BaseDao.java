package com.project.base.dao;

import java.io.Serializable;
import java.util.LinkedHashMap;
import java.util.List;

import org.hibernate.Criteria;


public interface BaseDao<T> {
	/**
	 * 获取记录总数
	 * 
	 * @param entityClass
	 *            实体类
	 * @return
	 */
	public long getCount();

	/**
	 * 清除一级缓存的数据
	 */
	public void clear();

	/**
	 * 保存实体
	 * 
	 * @param entity
	 *            实体id
	 */
	public Serializable save(T entity);

	/**
	 * 更新实体
	 * 
	 * @param entity
	 *            实体id
	 */
	public void update(T entity);

	/**
	 * 保存或更新实体
	 * 
	 * @param entity
	 *            实体id
	 * */
	public void saveOrUpdateEntity(T t);

	/**
	 * 删除实体
	 * 
	 * @param entityClass
	 *            实体类
	 * @param entityids
	 *            实体id数组
	 */
	public void delete(Serializable... entityids);

	/**
	 * 获取实体
	 * 
	 * @param <T>
	 * @param entityClass
	 *            实体类
	 * @param entityId
	 *            实体id
	 * @return
	 */
	public T find(Serializable entityId);

	/**
	 * 不分页，获取全部数据
	 * 
	 * @return
	 */
	public List<T> findAll();

	/**
	 * 通过hql获取多条数据
	 * 
	 * @param hql
	 * @param serializables
	 * @return
	 */
	public List<T> findEntityByHQL(String hql, Serializable... serializables);

	/**
	 * 通过hql单值检索(返回的结果有且仅有一条记录)
	 * 
	 * @param hql
	 * @param serializables
	 * @return
	 */
	public T findUniqueResult(String hql, Serializable... serializables);

	/**
	 * 批处理操作
	 * 
	 * @param hql
	 * @param serializables
	 */
	public void batchHandle(String hql, Serializable... serializables);

	/**
	 * 查询
	 * 
	 * @param clazz
	 * @param proMap
	 * @param orderMap
	 * @return
	 */
	public List findObjectListByParamAndOrder(Class clazz, LinkedHashMap proMap, LinkedHashMap orderMap);

	/**
	 * 保存实体
	 * 
	 * @param obj
	 * @param clazz
	 * @param key
	 * @return
	 */
	public Object save(Object obj, Class clazz, String key);

	/**
	 * 获取唯一的主键值
	 */
	public Long getUniqueId();

	public Long selectSequence();

	/**
	 * 删除实体
	 * 
	 * @param obj
	 */
	public void remove(Object obj);

	/**
	 * 通过参数查找实体
	 * 
	 * @param clazz
	 * @param propName
	 * @param propValue
	 * @return
	 */
	public List findObjectByPar(Class clazz, String propName, Object propValue);

	/**
	 * 出入参数,和排序的名称
	 * 
	 * @param clazz
	 * @param propName
	 * @param propValue
	 * @param orderName
	 * @param ascoOrdesc
	 * @return
	 */
	public List findObjectByParOrder(Class clazz, String propName, Object propValue, String orderName, String ascoOrdesc);

	/**
	 * 通过传多个参数来查询相应数据
	 * 
	 * @param clazz
	 * @param propNames
	 * @param propValues
	 * @return
	 */
	public List findObjectByPars(Class clazz, String[] propNames, Object[] propValues);

	/**
	 * 通过传多个参数来模糊查询相应数据
	 * 
	 * @param clazz
	 * @param propNames
	 * @param propValues
	 * @return
	 */
	public List findObjectByLikeParsOrder(Class clazz, String[] propNames, Object[] propValues, String[] orderNames, String[] ascoOrdescs);

	public List findObjectByParsOrder(Class clazz, String[] propNames, Object[] propValues, String orderName, String ascoOrdesc);

	/**
	 * 获取Criteria
	 * 
	 * @param clazz
	 * @return
	 */
	public Criteria getCriteria(Class clazz);

}
