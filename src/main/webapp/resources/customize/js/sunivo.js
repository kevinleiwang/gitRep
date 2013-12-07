var Sunivo = function($) {
	/**
	 * 处理日期时间控件
	 */
	var handleDatetimePickers = function() {
		var ctx = arguments.length > 0 ? arguments[0] : null;
		if ($.fn.datetimepicker) {
			var datetimePickers = $('.datetime-picker', ctx);
			// 打印日期时间控件个数
			// console.log("datetimePickers.size:" + datetimePickers.size());
			for (var i = 0; i < datetimePickers.size(); i++) {
				var datetimePicker = $(datetimePickers[i]);
				var dataDateFormat = datetimePicker.attr("data-date-format");
				var dateFormat = datetimePicker.attr("date-format");
				var dataDateMaxView = datetimePicker.attr("data-date-maxView");
				var dateMaxView = datetimePicker.attr("date-maxView");
				var dataDateLanguage = datetimePicker
						.attr("data-date-language");
				var dateLanguage = datetimePicker.attr("date-language");
				var dataDateMinView = datetimePicker.attr("data-date-minView");
				var dateMinView = datetimePicker.attr("date-minView");
				var dataDateStartDate = datetimePicker
						.attr("data-date-startDate");
				var dateStartDate = datetimePicker.attr("date-startDate");
				var dataDateEndDate = datetimePicker.attr("data-date-endDate");
				var dateEndDate = datetimePicker.attr("date-endDate");
				var dataDateMinuteStep = datetimePicker
						.attr("data-date-minuteStep");
				var dateMinuteStep = datetimePicker.attr("date-minuteStep");
				var dataDatePosition = datetimePicker
						.attr("data-date-position");
				var datePosition = datetimePicker.attr("date-position");
				datetimePicker.datetimepicker({
					format : dataDateFormat || dateFormat
							|| "yyyy-mm-dd hh:ii:ss",
					maxView : dataDateMaxView || dateMaxView || "decade",
					minView : dataDateMinView || dateMinView || "hour",
					autoclose : true,
					language : dataDateLanguage || dateLanguage || 'zh',
					startDate : dataDateStartDate || dateStartDate,
					endDate : dataDateEndDate || dateEndDate,
					viewSelect : "decade",
					minuteStep : parseInt(dataDateMinuteStep)
							|| parseInt(dateMinuteStep) || 10,
					pickerPosition : dataDatePosition || datePosition
							|| "bottom-left"
				});
			}
		}
	};

	/**
	 * 处理数字自动格式化<br>
	 * 需要引入autoNumeric.js
	 */
	var handleAutoNumeric = function(el) {
		var ctx = arguments.length > 0 ? arguments[0] : null;
		if ($.fn.autoNumeric) {
			var autoNumericList = $('.auto-numeric', ctx);
			for (var index = 0; index < autoNumericList.size(); index++) {
				var autoNumeric = $(autoNumericList[index]);
				autoNumeric.autoNumeric('init');
			}
		}
	};

	/**
	 * 处理异步加载时阻塞动画<br>
	 * 需要引入jquery.blockUI.js,当前不做支持
	 */
	var handleBlockUI = function(el) {
		// $(el)
		// .block(
		// {
		// message : '<img src="'
		// + ctx
		// + '/resources/common/static/img/loading.gif" align="absmiddle">',
		// css : {
		// border : 'none',
		// padding : '2px',
		// backgroundColor : 'none'
		// },
		// overlayCSS : {
		// backgroundColor : '#000',
		// opacity : 0.05,
		// cursor : 'wait'
		// }
		// });
	};

	/**
	 * 设置表单验证
	 */

	var handleTooltip = function() {
		var ctx = arguments.length > 0 ? arguments[0] : null;
		if (Sunivo.isTouchDevice()) { // if touch device, some tooltips can be
			// skipped in order to not conflict with
			// click events
			$('.tooltips:not(.no-tooltip-on-touch-device)', ctx).tooltip();
		} else {
			$('.tooltips', ctx).tooltip();
		}
	};

	var validation_option = {
		submitHandler : function(form) {
			form.submit();
		},

		errorPlacement : function(errors, element) {
			var error = errors[0];
			var isInput = element.is("input[type=text]");
			var isSelect = element.is("select");
			// 判断是chosen的条件:包含chosen或者chosen-with-diselect并且是select且不包括nochosen
			var isChosen = (element.hasClass("chosen") || element
					.hasClass("chosen-with-diselect"))
					&& isSelect && !element.hasClass("nochosen");
			var target = element;
			if (isChosen) {
				// if (isSelect) {
				var isMultiple = element.attr("multiple") != null;
				var $container = element.siblings(".chosen-container");
				if (isMultiple) {
					target = $container.find("ul");
				} else {
					target = $container.find("a.chosen-single");
				}
			}

			element.bind("change", {
				errors : errors
			}, function(event) {
				// console.log("2"+event.data.errors);
				if (this.value) {
					validation_option.unhighlight(this);
				} else {
					validation_option
							.errorPlacement(event.data.errors, $(this));
				}
			});

			target.addClass("error tooltips");
			target.attr("data-original-title", error.innerText);
			handleTooltip(element.parent());
		},

		unhighlight : function(element) {
			// console.log("unhighlight");
			var $element = $(element);
			var isInput = $element.is("input[type=text]");
			var isSelect = $element.is("select");

			// 判断是chosen的条件:包含chosen或者chosen-with-diselect并且是select且不包括nochosen
			var isChosen = ($element.hasClass("chosen") || $element
					.hasClass("chosen-with-diselect"))
					&& isSelect && !$element.hasClass("nochosen");
			var target = $element;
			if (isChosen) {
				// if (isSelect) {
				var isMultiple = $element.attr("multiple") != null;
				var $container = $element.siblings(".chosen-container");
				if (isMultiple) {
					target = $container.find("ul");
				} else {
					target = $container.find("a.chosen-single");
				}
			}
			// console.log(target);
			target.removeClass("error").removeClass("tooltips");
			target.removeAttr("data-original-title");
		},
		focusCleanup : false,
		focusInvalid : false,
		ignore : "",
		onkeyup : function() {
			// please do not delete this method
		}
	};

	$.validator.setDefaults(validation_option);

	var handleFormValidation = function() {
		var ctx = arguments.length > 0 ? arguments[0] : null;
		$("form.valid", ctx).validate(
				{
					invalidHandler : function(event, validator) {
						var errors = validator.numberOfInvalids();
						if (errors) {
							var message = "<li>表单中有错误，请完善表单后再提交。</li>";
							// console.log("handleFormValidation_ctx="+ctx);
							if (!ctx) {
								/*
								 * $("ul.error_container",
								 * "#error_message").html(message);
								 * $("#error_message").show();
								 */
								SunivoUtil.showAlertMessage("#error_message",
										"表单中有错误，请完善表单后再提交。", 'error');
							} else {
								/*
								 * $("ul.error_container", ctx).html(message);
								 * $(".error_message", ctx).show();
								 */
								/*
								 * SunivoUtil.showAlertMessage(ctx,
								 * "表单中有错误，请完善表单后再提交。", 'error');
								 */
								SunivoUtil.showAlertMessage($("#error_message",
										ctx), "表单中有错误，请完善表单后再提交。", 'error');
							}
						} else {
							if (!ctx) {
								$("div.error", "#error_message").hide();
							} else {
								$("div.error", ctx).hide();
							}
						}
					}
				});
	};

	/**
	 * 处理异步加载完成后取消阻塞动画
	 */
	var handleUnblockUI = function(el) {
		// $(el).unblock({
		// onUnblock : function() {
		// $(el).removeAttr("style");
		// }
		// });
	};

	/**
	 * 异步加载Section
	 */
	var handleLazySection = function() {
		$(".lazy-section").each(function() {
			$(this).removeClass("lazy-section");
			var baseUrl = $(this).attr("base-url");
			SunivoUtil.ajaxTurn2Page($(this), baseUrl, 1);
		});
	};

	var handleChosen = function() {
		/**
		 * 将chosen加在素有select上
		 */
		// $("select").attr("class", $("select").attr("class")+"
		// chosen-select-deselect");
		var config = {
			'.chosen-select' : {},
			// '.chosen-select-deselect' : {
			// allow_single_deselect : true
			// },
			'select' : {
				allow_single_deselect : true
			},
			'.chosen-select-no-single' : {
				disable_search_threshold : 10
			},
			'.chosen-select-no-results' : {
				no_results_text : 'Oops, nothing found!'
			},
			'.chosen-select-width' : {
				width : "95%"
			}
		};
		for ( var selector in config) {

			var selectorNew = selector + ":not(.nochosen)";
			/**
			 * 先摧毁，然后重建，防止重影
			 */
			// $(selector).chosen("destroy");
			$(selectorNew).chosen(config[selector]);
		}
	};

	/**
	 * 验证是否支持placeholder
	 */
	var placeholderSupport = function() {
		var t = document.createElement("input");
		t.type = "text";
		return (typeof t.placeholder !== "undefined");
	};

	/**
	 * 处理placeholder
	 */
	var handlePlaceholder = function() {
		var ctx = arguments.length > 0 ? arguments[0] : null;
		// 如果placeholder不被支持
		if (!placeholderSupport()) {
			var inputs = $("input", ctx);
			for (var i = 0; i < inputs.length; i++) {
				var curInput = inputs[i];
				if (!curInput.type || curInput.type == ""
						|| curInput.type == "text") {
					var curPlaceholder = curInput.getAttribute("placeholder");
					if (curPlaceholder && curPlaceholder.length > 0) {
						// 如果value为空，则展示placeholder
						if ("" === this.value) {
							curInput.value = curPlaceholder;
							curInput.setAttribute("old_color",
									curInput.style.color);
							curInput.style.color = "#c0c0c0";
						}
						curInput.onfocus = function() {
							this.style.color = this.getAttribute("old_color");
							if (this.value === curPlaceholder) {
								this.value = "";
							}
						};
						curInput.onblur = function() {
							if (this.value === "") {
								this.style.color = "#c0c0c0";
								this.value = curPlaceholder;
							}
						};
					}
				}
			}
		}
	};

	return {
		/**
		 * 页面整体初始化
		 */
		init : function() {
			handleDatetimePickers();
			handleLazySection();
			handleFormValidation();
			handleChosen();
			handleAutoNumeric();
			// handlePlaceholder();
		},

		/**
		 * 指定元素初始化
		 * 
		 * @param ctx
		 *            待初始化的元素选择器ID
		 */
		initContext : function(ctx) {
			// alert("执行了initContext");
			handleDatetimePickers(ctx);
			handleLazySection(ctx);
			handleFormValidation(ctx);
			handleChosen(ctx);
			handleAutoNumeric(ctx);
			// handlePlaceholder(ctx);
		},

		/**
		 * 异步加载时阻塞动画
		 * 
		 * @param el
		 *            操作的元素
		 */
		blockUI : function(el) {
			handleBlockUI(el);
		},

		/**
		 * 异步加载完成时取消阻塞动画
		 * 
		 * @param el
		 *            操作的元素
		 */
		unblockUI : function(el) {
			handleUnblockUI(el);
		},

		// check for device touch support
		isTouchDevice : function() {
			try {
				document.createEvent("TouchEvent");
				return true;
			} catch (e) {
				return false;
			}
		}
	};
}(window.jQuery);
var SunivoUtil = function($) {
	/**
	 * 处理翻页
	 */
	var handleTurn2Page = function() {
		// 获取要跳转到的页码
		var number = arguments.length > 0 ? arguments[0] : 1;
		// 获取页面上ID为page的元素
		var page = $("#page");
		// 获取页面上ID为filterForm的元素，该元素为一个表单
		var filterForm = $("#filterForm");
		if (page.length == 0) {
			page = $("<input type='hidden' name='number' id='number'>")
					.appendTo(filterForm);
		}
		// 设置跳转到的页码
		page.val(number);
		// 提交表单
		filterForm.submit();
	};

	/**
	 * 处理AJAX翻页
	 */
	var handleAjaxTurn2Page = function() {
		// 获取上下文选择器
		var contextSel = arguments.length > 0 ? arguments[0] : null;
		// 获取基础请求连接
		var baseUrl = arguments.length > 1 ? arguments[1] : "#";
		// 获取翻页的页码
		var number = arguments.length > 2 ? arguments[2] : "1";
		// Sunivo.blockUI(contextSel);
		$(contextSel).trigger({
			type : "startLoad",
			number : number
		});
		var form = $("form", contextSel);
		if (form.length == 0) {
			form = $(contextSel).parent("form");
		}
		if (form.length == 0) {
			form = $(contextSel).parents("form");
		}
		var param = $.extend({
			number : number
		}, form.serialize());
		$(contextSel).load(baseUrl, param, function() {
			// Sunivo.unblockUI(contextSel);
			Sunivo.initContext(contextSel);
			$(contextSel).trigger({
				type : "pageLoaded",
				number : number
			});
		});
	};

	/**
	 * 处理页面跳转
	 */
	var handleGo2Page = function() {
		// 获取要跳转到的页面链接
		var url = arguments.length > 0 ? arguments[0] : null;
		// 如果url为空，则打印警告
		if (null == url) {
			console.warn("url is null, can't goto");
		} else {
			window.location.href = url;
		}
	};

	/**
	 * 处理AJAX的JSON请求
	 */
	var handleAjaxJsonReq = function() {
		// 获取请求的连接
		var url = arguments.length > 0 ? arguments[0] : "";
		// 获取data
		var data = arguments.length > 1 ? arguments[1] : null;
		// 获取完成时的回调方法
		var doneCallback = arguments.length > 2 ? arguments[2] : null;
		// 获取请求方式
		var type = arguments.length > 3 ? arguments[3] : "POST";
		$.ajax({
			url : url,
			type : type,
			cache : false,
			dataType : "json",
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(data)
		}).done(function(data) {
			if (doneCallback) {
				doneCallback(data);
			}
		});
	};

	/**
	 * 处理模态对话关闭
	 */
	var handleModalHidden = function() {
		// console.log('handleModalHidden');
		// 清空页面体
		$("#modal_body").empty();
		// 如果确认按钮文本存在则替换为原文本
		if (modal_ok_btn_text) {
			$("#modal_ok_btn").text(modal_ok_btn_text);
		}
		// 如果确认按钮样式存在则替换为原样式
		if (modal_ok_btn_clazz) {
			$("#modal_ok_btn").attr("class", modal_ok_btn_clazz);
		}
		// 如果取消按钮文本存在则替换为原文本
		if (modal_cancel_btn_text) {
			$("#modal_cancel_btn").text(modal_cancel_btn_text);
		}
		// 如果取消按钮样式存在则替换为原样式
		if (modal_cancel_btn_clazz) {
			$("#modal_cancel_btn").attr("class", modal_cancel_btn_clazz);
		}
	};

	/**
	 * 加载Section页面
	 */
	/**
	 * 处理加载本地页面
	 */
	var handleCreateModal = function() {
		// 获取模态框标题
		var title = arguments.length > 0 ? arguments[0] : "默认标题";
		// 获取远程请求参数
		var data = arguments.length > 1 ? arguments[1] : null;
		// 获取确认后回调函数
		var confirmCallback = arguments.length > 2 ? arguments[2] : null;
		// 获取确认按钮个性文本
		var okButtonText = arguments.length > 3 ? arguments[3] : null;
		// 获取确认按钮样式
		var okButtonClazz = arguments.length > 4 ? arguments[4] : null;
		// 获取去雄按钮个性文本
		var cancelButtonText = arguments.length > 5 ? arguments[5] : null;
		// 获取取消按钮样式
		var cancelButtonClazz = arguments.length > 6 ? arguments[6] : null;
		handleBaseCreateModal(title, function() {
			$("#modal_body").html(data);
		}, function() {
			Sunivo.initContext("#modal_body");
		}, handleModalHidden, confirmCallback, okButtonText, okButtonClazz,
				cancelButtonText, cancelButtonClazz);
	};

	/**
	 * 处理加载远程页面到模态框
	 */
	var handleCreateRemoteModal = function() {
		// 获取模态框标题
		var title = arguments.length > 0 ? arguments[0] : "默认标题";
		// 获取模态框远程请求连接
		var bodySource = arguments.length > 1 ? arguments[1] : "#";
		// 获取远程请求参数
		var data = arguments.length > 2 ? arguments[2] : null;
		// 获取确认后回调函数
		var confirmCallback = arguments.length > 3 ? arguments[3] : null;
		// 获取确认按钮个性文本
		var okButtonText = arguments.length > 4 ? arguments[4] : null;
		// 获取确认按钮样式
		var okButtonClazz = arguments.length > 5 ? arguments[5] : null;
		// 获取去雄按钮个性文本
		var cancelButtonText = arguments.length > 6 ? arguments[6] : null;
		// 获取取消按钮样式
		var cancelButtonClazz = arguments.length > 7 ? arguments[7] : null;
		handleBaseCreateModal(title, function() {
			// console.log('执行初始化');
			$("#modal_body").load(bodySource, data, function() {
				Sunivo.initContext("#modal_body");
			});
		}, function() {
		}, handleModalHidden, confirmCallback, okButtonText, okButtonClazz,
				cancelButtonText, cancelButtonClazz);
	};

	/**
	 * 处理创建模态框基础方法
	 */
	var handleBaseCreateModal = function(title, bodyFunc, shownCallback,
			hiddenCallback, confirmCallback, okButtonText, okButtonClazz,
			cancelButtonText, cancelButtonClazz) {
		// 记录修改前确认按钮和取消按钮的样式和文本，防止修改后无法退回
		modal_ok_btn_text = $("#modal_ok_btn").text();
		modal_ok_btn_clazz = $("#modal_ok_btn").attr("class");
		modal_cancel_btn_text = $("#modal_cancel_btn").text();
		modal_cancel_btn_clazz = $("#modal_cancel_btn").attr("class");
		// 设置模态框标题
		$("#modal_title").html(title);
		// 加载模态框内容
		bodyFunc();
		// 如果确定按钮文本不为空，则设置为个性文本
		if (okButtonText) {
			$("#modal_ok_btn").text(okButtonText);
		}
		// 如果确认按钮样式不为空，则设置为个性样式
		if (okButtonClazz) {
			$("#modal_ok_btn").attr("class", "btn " + okButtonClazz);
		}
		// 如果取消按钮文本不为空，则设置为个性文本
		if (cancelButtonText) {
			$("#modal_cancel_btn").text(cancelButtonText);
		}
		// 如果取消按钮样式不为空，则设置为个性样式
		if (cancelButtonClazz) {
			$("#modal_cancel_btn").attr("class", "btn " + cancelButtonClazz);
		}
		// 更换确认按钮点击事件
		// 1.去掉确认按钮点击事件绑定
		$("#modal_ok_btn").unbind('click');
		// 2.定义点击事件
		var wrapperCallback = function() {
			if (false != confirmCallback()) {
				$('#modal_dialog').modal('hide');
			}
		};
		// 3.重新绑定确认按钮点击事件
		$("#modal_ok_btn").click(wrapperCallback);
		// 绑定模态框展示时触发事件
		$('#modal_dialog').one('shown', shownCallback);
		// 绑定模态框隐藏时触发事件
		// $('#modal_dialog').one('hidden', hiddenCallback);
		// 展示模态框
		$('#modal_dialog').modal({
			backdrop : true,
			show : true,
			remote : false
		});
	};

	/**
	 * 写入提示消息
	 */
	var handleAlertMessage = function() {
		// 上下文
		var ctx = arguments.length > 0 ? arguments[0] : null;
		// 消息
		var message = arguments.length > 1 ? arguments[1] : null;
		// 级别
		var level = arguments.length > 2 ? arguments[2] : "block";
		if (null == ctx || null == message) {
			console.log("ctx and message can't be null");
		} else {
			if ("info" != level && "success" != level && "block" != level
					&& "error" != level) {
				level = "block";
			}
			$(ctx)
					.html(
							"<div class='alert alert-"
									+ level
									+ "'>"
									+ "<i class='icon-remove close' data-dismiss='alert'></i>"
									+ message + "</div>");
		}
	};

	return {
		/**
		 * 翻页
		 * 
		 * @param number
		 *            需要跳转到的页码
		 */
		turn2Page : function(number) {
			handleTurn2Page(number);
		},

		/**
		 * AJAX翻页
		 * 
		 * @param contextSel
		 *            上下文选择器
		 * @param baseUrl
		 *            请求的基础URL
		 * @param number
		 *            翻页的页码
		 */
		ajaxTurn2Page : function(contextSel, baseUrl, number) {
			handleAjaxTurn2Page(contextSel, baseUrl, number);
		},

		/**
		 * 页面跳转
		 * 
		 * @param url
		 *            需要跳转到的url
		 */
		go2Page : function(url) {
			handleGo2Page(url);
		},

		/**
		 * 发送AJAX的JSON请求
		 * 
		 * @param url
		 *            请求的连接
		 * @param data
		 *            数据
		 * @param doneCallback
		 *            完成后回调方法
		 * @param type
		 *            请求类型，默认为POST
		 */
		ajaxJsonReq : function(url, data, doneCallback, type) {
			handleAjaxJsonReq(url, data, doneCallback, type);
		},

		/**
		 * 创建本地模态框
		 * 
		 * @param title
		 *            模态框标题
		 * @param data
		 *            模态框内容
		 * @param confirmCallback
		 *            确认后回调方法
		 * @param okButtonText
		 *            确认按钮个性内容
		 * @param okButtonClazz
		 *            确认按钮个性样式
		 *            <li>"":带渐变的标准灰色按钮
		 *            <li>btn-primary:提供额外的视觉感, 可在一系列的按钮中指出主要操作
		 *            <li>btn-info:默认样式的替代样式
		 *            <li>btn-success:表示成功或积极的动作
		 *            <li>btn-warning:提醒应该谨慎采取这个动作
		 *            <li>btn-danger:表示这个动作危险或存在危险
		 *            <li>btn-inverse:备用的暗灰色按钮，不依赖于语义和用途
		 *            <li>btn-link:简化一个按钮, 使它看起来像一个链接，同时保持按钮的行为
		 * @param cancelButtonText
		 *            取消按钮个性内容
		 * @param cancelButtonClazz
		 *            取消按钮个性样式
		 *            <li>"":带渐变的标准灰色按钮
		 *            <li>btn-primary:提供额外的视觉感, 可在一系列的按钮中指出主要操作
		 *            <li>btn-info:默认样式的替代样式
		 *            <li>btn-success:表示成功或积极的动作
		 *            <li>btn-warning:提醒应该谨慎采取这个动作
		 *            <li>btn-danger:表示这个动作危险或存在危险
		 *            <li>btn-inverse:备用的暗灰色按钮，不依赖于语义和用途
		 *            <li>btn-link:简化一个按钮, 使它看起来像一个链接，同时保持按钮的行为
		 */
		createModal : function(title, body, confirmCallback, okButtonText,
				okButtonClazz, cancelButtonText, cancelButtonClazz) {
			handleCreateModal(title, body, confirmCallback, okButtonText,
					okButtonClazz, cancelButtonText, cancelButtonClazz);
		},

		/**
		 * 创建远程模态框
		 * 
		 * @param title
		 *            模态框标题
		 * @param bodySource
		 *            远程请求
		 * @param data
		 *            请求参数
		 * @param confirmCallback
		 *            确认后回调方法
		 * @param okButtonText
		 *            确认按钮个性内容
		 * @param okButtonClazz
		 *            确认按钮个性样式
		 *            <li>"":带渐变的标准灰色按钮
		 *            <li>btn-primary:提供额外的视觉感, 可在一系列的按钮中指出主要操作
		 *            <li>btn-info:默认样式的替代样式
		 *            <li>btn-success:表示成功或积极的动作
		 *            <li>btn-warning:提醒应该谨慎采取这个动作
		 *            <li>btn-danger:表示这个动作危险或存在危险
		 *            <li>btn-inverse:备用的暗灰色按钮，不依赖于语义和用途
		 *            <li>btn-link:简化一个按钮, 使它看起来像一个链接，同时保持按钮的行为
		 * @param cancelButtonText
		 *            取消按钮个性内容
		 * @param cancelButtonClazz
		 *            取消按钮个性样式
		 *            <li>"":带渐变的标准灰色按钮
		 *            <li>btn-primary:提供额外的视觉感, 可在一系列的按钮中指出主要操作
		 *            <li>btn-info:默认样式的替代样式
		 *            <li>btn-success:表示成功或积极的动作
		 *            <li>btn-warning:提醒应该谨慎采取这个动作
		 *            <li>btn-danger:表示这个动作危险或存在危险
		 *            <li>btn-inverse:备用的暗灰色按钮，不依赖于语义和用途
		 *            <li>btn-link:简化一个按钮, 使它看起来像一个链接，同时保持按钮的行为
		 */
		createRemoteModal : function(title, bodySource, data, confirmCallback,
				okButtonText, okButtonClazz, cancelButtonText,
				cancelButtonClazz) {
			handleCreateRemoteModal(title, bodySource, data, confirmCallback,
					okButtonText, okButtonClazz, cancelButtonText,
					cancelButtonClazz);
		},

		/**
		 * 显示警告消息
		 * 
		 * @param ctx
		 *            上下文
		 * @param message
		 *            消息内容
		 * @param level
		 *            消息级别
		 *            <li>info
		 *            <li>success
		 *            <li>block
		 *            <li>error<br>
		 *            默认为block
		 */
		showAlertMessage : function(ctx, message, level) {
			handleAlertMessage(ctx, message, level);
		}
	};
}(window.jQuery);


String.prototype.trim = function(){
	return this.replace(/(^\s*)|(\s*$)/g, "");
}
