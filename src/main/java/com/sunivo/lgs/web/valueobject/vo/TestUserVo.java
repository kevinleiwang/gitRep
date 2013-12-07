/**
 * Description: 用户页面表单对象
 * Copyright:   Copyright (c)2013
 * Company:     SUNIVO
 * @author:     tradx
 * @version:    1.0
 * Create at:   2013-06-08 下午 20:09:56
 *  
 * Modification History:
 * Date         Author      Version     Description
 * ------------------------------------------------------------------
 * 2012-12-21   tradx   1.0         Initial
 */
package com.sunivo.lgs.web.valueobject.vo;

import com.sunivo.lgs.web.valueobject.entity.demo.TestUserEntity;



/**
 * 用户页面表单对象<br>
 * 
 * @author tradx
 * @version 1.0, 2013-06-08
 * @see
 * @since 1.0
 */
public class TestUserVo{
	/**
	 * 用户实体
	 */
	private TestUserEntity entity;
	

	/**
	 * 设置用户实体
	 * @param entity 用户实体
	 */
	public void setEntity(TestUserEntity entity) {
		this.entity = entity;
	}

	/**
	 * 获取用户实体
	 * @return 用户实体
	 */
	public TestUserEntity getEntity() {
		return this.entity;
	}
}