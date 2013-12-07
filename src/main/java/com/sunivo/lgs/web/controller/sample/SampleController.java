/**
 * Description: SOM_订单基础信息控制器
 * Copyright:   Copyright (c)2013
 * Company:     SUNIVO
 * @author: som
 * @version: 1.0
 * Create at:   2013-06-07 上午 11:19:03
 *
 * Modification History:
 * Date         Author      Version     Description
 * ------------------------------------------------------------------
 * 2012-12-21   som   1.0         Initial
 */
package com.sunivo.lgs.web.controller.sample;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sunivo.lgs.web.base.controller.BaseController;
import com.sunivo.lgs.web.valueobject.entity.demo.TestUserEntity;
import com.sunivo.lgs.web.valueobject.vo.TestUserVo;
import com.sunivo.ws.beans.domain.SampleBean;
import com.sunivo.ws.beans.request.SampleRequest;
import com.sunivo.ws.beans.response.SampleResponse;
import com.sunivo.ws.interfaces.server.crm.ICustomer;
import com.sunivo.ws.interfaces.server.sample.SampleServiceInterface;

/**
 * SOM_订单基础信息控制器<br>
 * 
 * @author som
 * @version 1.0, 2013-06-07
 * @see
 * @since 1.0
 */
@Controller
@RequestMapping("/sample")
public class SampleController extends BaseController {
    /*
     * @Autowired private DemoUserService demoUserService;
     */

    @Autowired
    private SampleServiceInterface sampleService;

    @Autowired
    private ICustomer customer;

    private static final Logger logger = Logger
            .getLogger(SampleController.class);

    /**
     * 表单提交 新增Sample
     * 
     * @param customerSaveVo
     * @return
     */
    @RequestMapping(value = "/saveSample1")
    public ModelAndView saveSample1(HttpServletRequest request) {
        logger.info("---进入到saveSample1---");
        // DemoCustomerRequest customerDemoRequest = new DemoCustomerRequest();
        // customerDemoRequest.setAge()
        // demoUserService.addUser(customerDemoRequest);
        return new ModelAndView(getAutoUrl());
    }

    /**
     * ajax提交 新增Sample
     * 
     * @param customerSaveVo
     * @return
     */
    // @RequestMapping(value = "/saveSample", method = RequestMethod.POST,
    // produces = MediaType.APPLICATION_JSON_VALUE)
    /* @RequestMapping(value = "/saveSample") */
    @RequestMapping(value = "saveSample", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public String saveSample(HttpServletRequest request) {
        try {
            logger.info("---进入到saveSample---");
            String name = request.getParameter("name");
            String age = request.getParameter("age");
            String sex = request.getParameter("sex");
            String birthday = request.getParameter("birthday");
            // DemoCustomerRequest customerDemoRequest = new
            // DemoCustomerRequest();
            // customerDemoRequest.setAge()
            // demoUserService.addUser(customerDemoRequest);
            SampleRequest sampleRequest = new SampleRequest();
            SampleBean sampleBean = new SampleBean();
            sampleBean.setName(name);
            if (!StringUtils.isEmpty(sex)) {
                sampleBean.setSex(Integer.parseInt(sex));
            }
            sampleBean.setBirthdayStr(birthday + " 00:00:00");
            sampleRequest.setSampleBean(sampleBean);
            SampleResponse sampleResponse = sampleService
                    .addUser(sampleRequest);
            // sampleResponse.
            if (sampleResponse != null) {
                return sampleResponse.getResultCode();
            }
        } catch (Exception e) {
            logger.info("save cus happend exception!", e);
            return null;
        }
        return "1";
    }

    /* @SuppressWarnings("rawtypes") */
    @RequestMapping(value = "/testUser", method = RequestMethod.POST)
    public String testUser(HttpServletRequest request, Integer number) {
        try {
            // logger.info("-->OrdInfo page number ::" + number);
            System.out.println("获取数据测试！！！！");
            return getAutoUrl();
        } catch (Exception e) {
            logger.error("query from crm happend exception!", e);
            return getAutoUrl();
        } finally {
            logger.info("-------------query cuscomtomer over---------");
        }
    }

    @RequestMapping(value = "/listSample", method = RequestMethod.GET)
    public String listSample(HttpServletRequest request, Integer number) {
        try {
            return getAutoUrl();
        } catch (Exception e) {
            return getAutoUrl();
        } finally {

        }
    }

    @RequestMapping(value = "/listSample2", method = RequestMethod.GET)
    public String listSample2(HttpServletRequest request, Integer number) {
        try {
            return getAutoUrl();
        } catch (Exception e) {
            return getAutoUrl();
        } finally {

        }
    }

    @RequestMapping(value = "/formSample", method = RequestMethod.GET)
    public String formSample(HttpServletRequest request, Integer number) {
        try {
            return getAutoUrl();
        } catch (Exception e) {
            return getAutoUrl();
        } finally {

        }
    }

    @RequestMapping(value = "/hessionSample", method = RequestMethod.GET)
    public String hessionSample(HttpServletRequest request, Integer number) {
        try {
            logger.info("-------------hessionSample begin---------");
            /*
             * QueryCustomerInfoRequest request1 =new
             * QueryCustomerInfoRequest(); request1.setCustomerType("04");
             * CustomerInfoExt entity = new CustomerInfoExt();
             * entity.setRoleType("04"); request1.setEntity(entity);
             * QueryCustomerInfoResponse response = customer
             * .queryCustomerInfo(request1);
             */
            return getAutoUrl();
        } catch (Exception e) {
            return getAutoUrl();
        } finally {

        }
    }

    @RequestMapping(value = "/menuSample", method = RequestMethod.GET)
    public String menuSample(HttpServletRequest request, Integer number) {
        try {
            logger.info("-------------menuSample begin---------");
            return getAutoUrl();
        } catch (Exception e) {
            return getAutoUrl();
        } finally {

        }
    }

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String list(Integer number, Model model, HttpServletRequest request) {
        try {
            // logger.info("-->OrdInfo page number ::" + number);
            logger.info("----------获取数据测试！！！！begin---------");
            List testUsers = new ArrayList();
            testUsers.add(createUserEntity());
            request.setAttribute("testUsers", testUsers);
            // return AutoGetURL().replace("testUser", "index");
            // DemoCustomerRequest demoRequest = new DemoCustomerRequest();
            // demoUserService.addUser(demoRequest);

            /*
             * DemoCustomerResponse demoCustomerResponse = demoUserService
             * .findUser("倪瑞");
             * logger.info("-----获取数据测试！！！！end---sunivoResponse=" +
             * demoCustomerResponse.getSex() + "=====" +
             * demoCustomerResponse.getAge());
             */

            logger.info("----------获取数据测试！！！！end---------");
            return getAutoUrl();
        } catch (Exception e) {
            logger.error("query from crm happend exception!", e);
            return getAutoUrl();
        } finally {
            logger.info("-------------query user over---------");
        }
    }

    /*
     * @SuppressWarnings("rawtypes")
     * 
     * @RequestMapping(value = "/testUser", method = RequestMethod.GET)
     * 
     * @BusinessDesc(ModuleDesc = MODULE_DES, MethodDesc = ORDINFO_SAVEFIR_CUS)
     * public String testUser(HttpServletRequest request, Integer number) { try
     * { //logger.info("-->OrdInfo page number ::" + number);
     * System.out.println("获取数据测试！！！！"); List testUsers = new ArrayList();
     * testUsers.add(createUserEntity()); request.setAttribute("testUsers",
     * testUsers); //return AutoGetURL().replace("testUser", "index"); return
     * AutoGetURL(); } catch (Exception e) {
     * logger.error("query from crm happend exception!", e); return
     * AutoGetURL(); } finally {
     * logger.info("-------------query user over---------"); } }
     */

    public TestUserEntity createUserEntity() {
        TestUserEntity entity = new TestUserEntity();
        entity.setBirthDay(new Date());
        entity.setCityId(1);
        entity.setDeposit(200);
        entity.setEmail("niruiok@126.com");
        entity.setId(1);
        entity.setHeight(186);
        entity.setPassword("123456");
        entity.setName("倪瑞");
        return entity;
    }

    /**
     * 删除用户
     * 
     * @param id
     *            用户页面表单对象唯一标识
     * @param page
     *            分页配置
     * @param request
     *            请求对象
     * @return 结果视图
     */
    @RequestMapping(value = "/{id}", method = { RequestMethod.DELETE })
    @ResponseStatus(HttpStatus.OK)
    public void delete(@PathVariable Integer id) {
        // testUserService.delete(id);
        logger.info("-------------deleteUser---------");
    }

    /**
     * 去修改用户
     * 
     * @param id
     *            用户页面表单对象唯一标识
     * @param request
     *            请求对象
     * @return 结果视图
     */
    @RequestMapping(value = "/{id}", method = { RequestMethod.GET }, params = "action=edit")
    public String updateForm(@PathVariable(value = "id") Integer id, Model model) {
        logger.info("-------------updateUser---------");
        model.addAttribute("entity", createUserEntity());
        model.addAttribute("action", "edit");
        return getAutoUrl("form");
    }

    /**
     * 去新增用户
     * 
     * @return 结果视图
     */
    @RequestMapping(value = "testPopSection")
    public String testPopSection(Model model) {
        model.addAttribute("action", "create");
        logger.info("-------------addUser---------");
        return getAutoUrl();
    }

    @RequestMapping(value = "testPopValidateSection")
    public String testPopValidateSection(Model model) {
        model.addAttribute("action", "create");
        logger.info("-------------addUser---------");
        return getAutoUrl();
    }

    @RequestMapping(value = "/{id}", method = { RequestMethod.GET })
    public String showForm(@PathVariable(value = "id") Integer id, Model model) {
        /* model.addAttribute("entity", testUserService.getById(id)); */
        model.addAttribute("entity", createUserEntity());
        return getAutoUrl("form");
    }

    /**
     * 添加保存
     * 
     * @param vo
     * @param result
     * @param id
     * @param redirectAttributes
     * @param model
     * @return
     */
    @RequestMapping(value = "/{id}", method = { RequestMethod.POST })
    public String updateTestUser(TestUserVo vo, BindingResult result,
            @PathVariable Integer id, RedirectAttributes redirectAttributes,
            Model model) {
        TestUserEntity entity = vo.getEntity();
        model.addAttribute("entity", entity);
        /* subValidation(result, entity); */
        // 表单验证无误,进行提交
        if (result.hasErrors()) {
            model.addAttribute("action", "edit");
            return getAutoUrl("form");
        } else {
            try {
                /* testUserService.update(entity); */
                redirectAttributes.addAttribute("message", "更新成功");
                return "redirect:/sample/" + entity.getId();
            } catch (Exception se) {
                // ErrorsUtil.rejectErrors(model, se.getMessage());
                model.addAttribute("action", "edit");
                return getAutoUrl("form");
            }
        }
    }

    /**
     * 警告弹窗样例
     * 
     * @param levelStr
     *            弹窗内容级别
     * @param message
     *            弹窗内容
     * @param model
     *            模型对象
     * @return 视图
     */
    @RequestMapping(value = "/alertMessage", method = { RequestMethod.GET,
            RequestMethod.POST })
    public String alertMessage(String levelStr, Model model) {
        if (StringUtils.isBlank(levelStr)) {
            addMessage(model, "简单消息");
        } else if ("default".equals(levelStr)) {
            addDefaultMessage(model, "默认消息");
        } else if ("info".equals(levelStr)) {
            addInfoMessage(model, "信息消息");
        } else if ("success".equals(levelStr)) {
            addSuccessMessage(model, "成功消息");
        } else if ("warn".equals(levelStr)) {
            addWarnMessage(model, "警告消息");
        } else if ("error".equals(levelStr)) {
            addErrorMessage(model, "错误消息");
        } else if ("all".equals(levelStr)) {
            addMessage(model, "全部-简单消息");
            addInfoMessage(model, "全部-信息消息1", "全部-信息消息2", "全部-信息消息3");
        } else {
            addDefaultMessage(model, "默认信息");
        }
        return getAutoUrl();
    }

    /**
     * 弹窗样例
     * 
     * @param model
     *            模型对象
     * @return 视图
     */
    @RequestMapping(value = "/modelPop", method = { RequestMethod.GET,
            RequestMethod.POST })
    public String modelPop(Model model) {
        return getAutoUrl();
    }

    /**
     * 自定义标签样例
     * 
     * @param model
     *            模型对象
     * @return 视图
     */
    @RequestMapping(value = "/tagsSample", method = { RequestMethod.GET,
            RequestMethod.POST })
    public String tagsSample(Model model) {
        return getAutoUrl();
    }

    /**
     * 下拉列表自定义标签样例
     * 
     * @param model
     *            模型对象
     * @return 视图
     */
    @RequestMapping(value = "/selectTagsSampleSection", method = {
            RequestMethod.GET, RequestMethod.POST })
    public String selectTagsSampleSection(Model model) {
        return getAutoUrl();
    }

    /**
     * 单选按钮自定义标签样例
     * 
     * @param model
     *            模型对象
     * @return 视图
     */
    @RequestMapping(value = "/radioTagsSampleSection", method = {
            RequestMethod.GET, RequestMethod.POST })
    public String radioTagsSampleSection(Model model) {
        return getAutoUrl();
    }

    /**
     * 展示自定义标签样例
     * 
     * @param model
     *            模型对象
     * @return 视图
     */
    @RequestMapping(value = "/viewTagsSampleSection", method = {
            RequestMethod.GET, RequestMethod.POST })
    public String viewTagsSampleSection(Model model) {
        return getAutoUrl();
    }

    /**
     * 开关样例
     * 
     * @param model
     *            模型对象
     * @return 视图
     */
    @RequestMapping(value = "/switchSample", method = { RequestMethod.GET,
            RequestMethod.POST })
    public String switchSample(Model model) {
        return getAutoUrl();
    }
}
