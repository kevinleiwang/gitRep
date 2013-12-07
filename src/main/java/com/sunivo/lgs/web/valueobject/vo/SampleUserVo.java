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

import java.util.Date;



/**
 * 用户页面表单对象<br>
 * 
 * @author sunivo
 * @version 1.0, 2013-10-23
 * @see
 * @since 1.0
 */
public class SampleUserVo{
	private String name;
	private Integer age;
	private Integer sex;
	private Date birthday;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getAge() {
		return age;
	}
	public void setAge(Integer age) {
		this.age = age;
	}
	public Integer getSex() {
		return sex;
	}
	public void setSex(Integer sex) {
		this.sex = sex;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	
}