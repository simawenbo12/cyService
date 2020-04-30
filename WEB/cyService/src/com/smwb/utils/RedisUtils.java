package com.smwb.utils;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

/**
 * 
 * @author 司马文铂
 * @time 2018年12月30日下午7:52:35
 */
public class RedisUtils {
    public static JedisPool jedisPool;// redis连接池对象

    public static JedisPool getJedisPool() {
        return jedisPool;
    }

    public static void setJedisPool(JedisPool jedisPool) {
        RedisUtils.jedisPool = jedisPool;
    }

    public static  void set(String key, String value) { 
        Jedis jedis = null;
        try {
            jedis = jedisPool.getResource();// 获取jedis对象
            jedis.set(key, value);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 返还到连接池
            returnResource(jedisPool, jedis);
        }
    }
    //设置键值对带过期时间
    public static void set(String key, String value, int expireTime) {
        Jedis jedis = null;
        try {
            jedis = jedisPool.getResource();
            jedis.set(key, value);
            jedis.expire(key, expireTime); //设置过期时间
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        	returnResource(jedisPool, jedis);
        }
    }
    
    //set集合 内部的键值对是无序的唯一的
    public static void sadd(String key,String member) {
    	 Jedis jedis = null;
         try {
             jedis = jedisPool.getResource();
             jedis.sadd(key,member);
         } catch (Exception e) {
             e.printStackTrace();
         } finally {
         	returnResource(jedisPool, jedis);
         }
    }
    
    // hash组  添加一个对应关系
    public static void hset(String key, String fieid,String value) {
    	Jedis jedis = null;
    	try {
            jedis = jedisPool.getResource();
            jedis.hset(key,fieid,value);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        	returnResource(jedisPool, jedis);
        }
    }
    
    // hash组  获取一个对应关系
    public static String hget(String key, String fieid) {
    	Jedis jedis = null;
    	String value = null;
    	try { 
            jedis = jedisPool.getResource();
            value = jedis.hget(key,fieid);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        	returnResource(jedisPool, jedis);
        }
		return value;
    }
    
    //设置自增ID
    public static long incr(String key,int expireTime){
    	 Jedis jedis = null;
    	 long len = 0;
         try {
             jedis = jedisPool.getResource();
             len = jedis.incr(key);
             jedis.expire(key, expireTime); //设置过期时间
         } catch (Exception e) {
             e.printStackTrace();
         } finally {
        	 returnResource(jedisPool, jedis);
         }
         return len;
    }
    
    
    public static boolean exist(String key) {
        Jedis jedis = null;
        try {
            jedis = jedisPool.getResource();
            return jedis.exists(key);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 返还到连接池
            returnResource(jedisPool, jedis);
        }
        return false;
    }
    
    //获取字符串对应的数据
    public static String get(String key) {
        String value = null;
        Jedis jedis = null;
        try {
            jedis = jedisPool.getResource();
            value = jedis.get(key);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 返还到连接池
            returnResource(jedisPool, jedis);
        }
        return value;
    }

    //返还到连接池
	public static void returnResource(JedisPool jedisPool, Jedis jedis) {
        if (jedis != null) {
            jedis.close();
        }
    }
    
}