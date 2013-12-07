/**
 * Description: 用户数据库实体/领域对象
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
package com.sunivo.lgs.web.valueobject.entity.demo;

import javax.validation.constraints.Max;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
//import org.sunivo.core.dao.DomainObject;


/**
 * 用户数据库实体/领域对象<br>
 * 
 * @author tradx
 * @version 1.0, 2013-06-08
 * @see
 * @since 1.0
 */
/*public class TestUserEntity extends DomainObject {*/
public class TestUserEntity{
//	public class TestUserEntity {
    /**
	 * 
	 */
    private static final long serialVersionUID = 1L;

    // 可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
    // columns START
    /**
     * ID
     */

    private java.lang.Integer id;

    /**
     * 姓名
     */
    @Length(max = 30)
    private java.lang.String name;

    /**
     * 性别
     */
    private Integer sex;

    /**
     * 生日
     */
    private java.util.Date birthDay;

    /**
     * 城市
     */

    private java.lang.Integer cityId;

    /**
     * 身高
     */

    private java.lang.Integer height;

    /**
     * 体重
     */
    @Max(32767)
    private Double weight;

    /**
     * 邮箱
     */
    @Email
    @Length(max = 30)
    private java.lang.String email;

    /**
     * 密码
     */
    @Length(max = 30)
    private java.lang.String password;

    /**
     * 存款
     */

    private java.lang.Integer deposit;

    /**
     * 备注
     */
    @Length(max = 1000)
    private java.lang.String note;

    // columns END
    /*
     * public TestUser(){ }
     * 
     * public TestUser( java.lang.Integer id ){ this.id = id; }
     */

    /**
     * 设置ID
     * 
     * @param id
     *            ID
     */
    public void setId(java.lang.Integer id) {
        this.id = id;
    }

    /**
     * 获取ID
     * 
     * @return ID
     */
    public java.lang.Integer getId() {
        return this.id;
    }

    /**
     * 设置姓名
     * 
     * @param name
     *            姓名
     */
    public void setName(java.lang.String name) {
        this.name = name;
    }

    /**
     * 获取姓名
     * 
     * @return 姓名
     */
    public java.lang.String getName() {
        return this.name;
    }


    /**
     * 设置生日
     * 
     * @param birthDay
     *            生日
     */
    public void setBirthDay(java.util.Date birthDay) {
        this.birthDay = birthDay;
    }

    /**
     * 设置生日字符串格式
     * 
     * @param birthDay
     *            生日
     */
    public void setBirthDayStr(String birthDay) {
        if (birthDay!=null && !birthDay.equals("")) {
            try {
                this.birthDay = java.text.DateFormat.getDateTimeInstance()
                        .parse(birthDay);
            } catch (java.text.ParseException ex) {
                ex.printStackTrace();
            }
        }
    }

    /**
     * 获取生日
     * 
     * @return 生日
     */
    public java.util.Date getBirthDay() {
        return this.birthDay;
    }

    /**
     * 设置城市
     * 
     * @param cityId
     *            城市
     */
    public void setCityId(java.lang.Integer cityId) {
        this.cityId = cityId;
    }

    /**
     * 获取城市
     * 
     * @return 城市
     */
    public java.lang.Integer getCityId() {
        return this.cityId;
    }

    /**
     * 设置身高
     * 
     * @param height
     *            身高
     */
    public void setHeight(java.lang.Integer height) {
        this.height = height;
    }

    /**
     * 获取身高
     * 
     * @return 身高
     */
    public java.lang.Integer getHeight() {
        return this.height;
    }

    /**
     * 设置体重
     * 
     * @param weight
     *            体重
     */
    public void setWeight(Double weight) {
        this.weight = weight;
    }

    /**
     * 获取体重
     * 
     * @return 体重
     */
    public Double getWeight() {
        return this.weight;
    }

    /**
     * 设置邮箱
     * 
     * @param email
     *            邮箱
     */
    public void setEmail(java.lang.String email) {
        this.email = email;
    }

    /**
     * 获取邮箱
     * 
     * @return 邮箱
     */
    public java.lang.String getEmail() {
        return this.email;
    }

    /**
     * 设置密码
     * 
     * @param password
     *            密码
     */
    public void setPassword(java.lang.String password) {
        this.password = password;
    }

    /**
     * 获取密码
     * 
     * @return 密码
     */
    public java.lang.String getPassword() {
        return this.password;
    }

    /**
     * 设置存款
     * 
     * @param deposit
     *            存款
     */
    public void setDeposit(java.lang.Integer deposit) {
        this.deposit = deposit;
    }

    /**
     * 获取存款
     * 
     * @return 存款
     */
    public java.lang.Integer getDeposit() {
        return this.deposit;
    }

    /**
     * 设置备注
     * 
     * @param note
     *            备注
     */
    public void setNote(java.lang.String note) {
        this.note = note;
    }

    /**
     * 获取备注
     * 
     * @return 备注
     */
    public java.lang.String getNote() {
        return this.note;
    }

    /**
     * 实体的toString方法
     * 
     * @return 实体字符串
     */
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("Id", getId()).append("Name", getName())
                .append("Sex", getSex()).append("BirthDay", getBirthDay())
                .append("CityId", getCityId()).append("Height", getHeight())
                .append("Weight", getWeight()).append("Email", getEmail())
                .append("Password", getPassword())
                .append("Deposit", getDeposit()).append("Note", getNote())
                .toString();
    }

    public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	/**
     * 获取hash码
     * 
     * @return HASH码
     */
    public int hashCode() {
        return new HashCodeBuilder().append(getId()).toHashCode();
    }

    /**
     * 对象比较
     * 
     * @param obj
     *            待比较对象
     * @return 是否相同<li>true--相同<li>false--不相同
     */
    public boolean equals(Object obj) {
        if (obj instanceof TestUserEntity == false)
            return false;
        if (this == obj)
            return true;
        TestUserEntity other = (TestUserEntity) obj;
        return new EqualsBuilder().append(getId(), other.getId()).isEquals();
    }
}
