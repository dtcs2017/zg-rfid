/*
 * Powered By [rapid-framework]
 * Web Site: http://www.rapid-framework.org.cn
 * Google Code: http://code.google.com/p/rapid-framework/
 */

package com.boco.zg.plan.base.service;

import org.springframework.stereotype.Component;

import cn.org.rapid_framework.page.PageRequest;

import java.util.*;

import javacommon.base.*;
import javacommon.util.*;
import javacommon.base.model.*;

import cn.org.rapid_framework.util.*;
import cn.org.rapid_framework.web.util.*;
import cn.org.rapid_framework.page.*;
import cn.org.rapid_framework.page.impl.*;
import cn.org.rapid_framework.beanutils.BeanUtils;

import com.boco.zg.plan.base.model.*;
import com.boco.zg.plan.base.dao.*;
import com.boco.zg.plan.base.service.*;

/**
 * @author 李智伟 email:v_lizhiwei@boco.com.cn
 * @version 1.0
 * @since 1.0
 */

@Component
public class ZgTbackBo extends BaseManager<ZgTback,java.lang.String>{
	private ZgTbackDao zgTbackDao;
	/**增加setXXXX()方法,spring就可以通过autowire自动设置对象属性*/
	public void setZgTbackDao(ZgTbackDao dao) {
		this.zgTbackDao = dao;
	}
	public EntityDao getEntityDao() {
		return this.zgTbackDao;
	}
	public Page findByPageRequest(PageRequest pr) {
		return zgTbackDao.findByPageRequest(pr);
	}
	
	public void removeById(java.lang.String id) {
		zgTbackDao.deleteById(id);
	}
	
	public List<ZgTback> findByRequest(PageRequest pageRequest) {
		return zgTbackDao.findByRequest(pageRequest);
	}
}
