jQuery.validator
		.addMethod(
				"cdate",
				function(value, element) {
					return this.optional(element)
							|| /^[1-9]\d{3}[\/\-]((0?[1-9])|(1[0-2]))[\/\-]((0?[1-9])|([1-2]\d)|(3[01]))$/
									.test(value);
				}, "请输入有效的日期(yyyy-mm-dd)");
jQuery.validator
		.addMethod(
				"cdatetime",
				function(value, element) {
					return this.optional(element)
							|| /^[1-9]\d{3}[\/\-]((0?[1-9])|(1[0-2]))[\/\-]((0?[1-9])|([1-2]\d)|(3[01])) (([01]\d)|(2[0-3]))(:(([0-4]\d)|(5[0-9]))){2}$/
									.test(value);
				}, "请输入有效的时间(yyyy-MM-dd hh:mm:ss)");
jQuery.validator.addMethod("nonNegativeInteger", function(value, element) {
	return this.optional(element) || /^\d+$/.test(value);
}, "请输入非负整数");
jQuery.validator.addMethod("positiveInteger", function(value, element) {
	return this.optional(element) || /^([1-9]\d*)$/.test(value);
}, "请输入正整数");
jQuery.validator.addMethod("positiveNumber", function(value, element) {
	return this.optional(element) || /^(0|([1-9]\d*))(\.\d+)?$/.test(value);
}, "请输入正数");
jQuery.validator.addMethod("mobile", function(value, element) {
	return this.optional(element)
			|| /^(((00)|(\+))?86(-| )?)?1\d{10}$/.test(value);
}, "请输入正确手机号码");
jQuery.validator.addMethod("zipCode", function(value, element) {
	return this.optional(element) || /^[1-9]\d{5}$/.test(value);
}, "请输入正确邮政编码");
jQuery.validator.addMethod("hsCode", function(value, element) {
	return this.optional(element) || /^\d[\.\d]*$/.test(value);
}, "请输入正确HSCode");
jQuery.validator.addMethod("simpleName", function(value, element) {
	return this.optional(element)
			|| /^[a-zA-Z0-9\u4E00-\u9FA5, \-_\.&\(\)@]*$/.test(value);
}, "请不要输入特殊字符或者全角字符");
jQuery.validator.addMethod("dateGt", function(value, element, param) {
	var $target = $(param);
	var targetVal = $target.val();
	if (isEmptyVal(targetVal)) {
		// 当比较值为空时，不做判断
		// return this.optional(element);
		return true;
	} else {
		return this.optional(element) || (value > targetVal);
	}
}, "日期取值过小");
jQuery.validator.addMethod("dateGte", function(value, element, param) {
	var $target = $(param);
	var targetVal = $target.val();
	if (isEmptyVal(targetVal)) {
		// 当比较值为空时，不做判断
		// return this.optional(element);
		return true;
	} else {
		return this.optional(element) || (value >= targetVal);
	}
}, "日期取值过小");
jQuery.validator.addMethod("dateEq", function(value, element, param) {
	var $target = $(param);
	var targetVal = $target.val();
	if (isEmptyVal(targetVal)) {
		// 当比较值为空时，不做判断
		// return this.optional(element);
		return true;
	} else {
		return this.optional(element) || (value == targetVal);
	}
}, "日期取值错误");
jQuery.validator.addMethod("dateLte", function(value, element, param) {
	var $target = $(param);
	var targetVal = $target.val();
	if (isEmptyVal(targetVal)) {
		// 当比较值为空时，不做判断
		// return this.optional(element);
		return true;
	} else {
		return this.optional(element) || (value <= targetVal);
	}
}, "日期取值过大");
jQuery.validator.addMethod("dateLt", function(value, element, param) {
	var $target = $(param);
	var targetVal = $target.val();
	if (isEmptyVal(targetVal)) {
		// 当比较值为空时，不做判断
		// return this.optional(element);
		return true;
	} else {
		return this.optional(element) || (value < targetVal);
	}
}, "日期取值过大");
/**
 * 判断取值是否为空
 * 
 * @param val
 *            待判断的取值
 * @returns {Boolean}
 */
function isEmptyVal(val) {
	return (!val || 'undefined' == (typeof val) || undefined == val
			|| null == val || "" == val);
}
/**
 * JQuery验证规则使用方法：<br>
 * class="required" 等价于 class="required:true"<br>
 * class="a b"要求a和b都做验证<br>
 * <p>
 * JQuery默认提供的验证规则列表： <br>
 * required:必填 例如：
 * <li>required:true-->必填
 * <li>required:"#aa:checked"-->表达式为真时必填
 * <li>required:function()-->方法为真时必填<br>
 * remote:远程验证 例如：
 * <li>remote:url-->url服务端验证为真时验证通过<br>
 * email:邮箱<br>
 * url:URL<br>
 * date:日期<br>
 * dateISO:日期<br>
 * number:数字 <br>
 * digits:数字<br>
 * creditcard:信用卡<br>
 * dom属性中增加equalTo="等值验证" 例如：
 * <li>dom属性中增加equalTo="#password"-->与指定表单字段是否相同<br>
 * maxlength:最大长度 例如：
 * <li>maxlength:12 <br>
 * minlength:最小长度 例如：
 * <li>minlength:6<br>
 * rangelength:长度取值范围 例如：
 * <li>rangelength:[6,12]<br>
 * max:最大值 例如：
 * <li>max:100<br>
 * min:最小值 例如：
 * <li>min:0<br>
 * range:取值范围 例如：
 * <li>range:[0,100]<br>
 * <p>
 * 自定义验证规则列表：<br>
 * cdate:yyyy-MM-dd格式日期<br>
 * nonNegativeInteger:非负整数<br>
 * positiveInteger:正整数<br>
 * positiveNumber:正数<br>
 * mobile:手机号码<br>
 * zipCode:邮政编码<br>
 * dom属性中增加dateGt="#beginDate"-->日期大于表单字段<br>
 * dom属性中增加dateGte="#beginDate"-->日期大于等于表单字段<br>
 * dom属性中增加dateEq="#beginDate"-->日期等于表单字段<br>
 * dom属性中增加dateLte="#beginDate"-->日期小于等于表单字段<br>
 * dom属性中增加dateLt="#beginDate"-->日期小于表单字段<br>
 */
