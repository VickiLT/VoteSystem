package com.vote.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.vote.dao.FileDao;
import com.vote.entity.*;
import com.vote.service.*;
import com.vote.service.Impl.KeyServiceImpl;
import com.vote.util.AESUtil;
import com.vote.util.FileUtil;
import com.vote.util.LogUtils;
import com.vote.util.MailUtil;
import common.CommonResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

/**
 * 创建投票项目
 * Created by sunwe on 2018/3/12.
 */
@Controller
@RequestMapping(value = "/vote")
public class VoteController {

    @Autowired
    private DetailsService detailsService;

    @Autowired
    private VoteProjectService voteProjectService;

    @Autowired
    private VoteItemService voteItemService;

    @Autowired
    private VoteDetailsService voteDetailsService;

    @Autowired
    private KeyService keyService;

    @Autowired
    private FileDao fileDao;

    @Autowired
    private UserService userService;

    @Autowired
    private  ManagerService managerService;

    @Autowired
    private SecretaryService secretaryService;

    @RequestMapping("/createVote/firstStep")
    public String firstStep(VoteProject voteProject, Model model, HttpServletRequest request) throws UnsupportedEncodingException {
        if (voteProject.isVoteMode() == false) {
            model.addAttribute("mode", 1);
        } else {
            model.addAttribute("mode", "");
        }
        model.addAttribute("voteProject", voteProject);

        return "vote/newvotecontext";
    }

    @RequestMapping(value = "/createVote/show", method = {RequestMethod.POST},produces = "text/html;charset=utf-8")
    public String createVoteShow( Model model,VoteProject voteProject,HttpServletRequest request) throws ParseException {
        VoteProject vp = new VoteProject();
        String time = voteProject.getTime();
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM-dd-yyyy HH:mm:ss");
        Date date = dateFormat.parse(time);
        if (voteProject != null) {
            vp.setSelectNum(String.valueOf(voteProject.getSelectNum()));
            vp.setVoteTitle(voteProject.getVoteTitle());
            vp.setVoteSum(String.valueOf(voteProject.getVoteSum()));
            vp.setIsCheckResults(voteProject.getIsCheckResults());
            vp.setIsModifyVote(voteProject.getIsModifyVote());
            vp.setVoteMode(voteProject.isVoteMode());
            vp.setContent(voteProject.getContent());
            vp.setCreateTime(new Date());
            vp.setEndTime(date);
            vp.setClose(true);
            vp.setVoteExplain(voteProject.getVoteExplain());
            voteProjectService.insert(vp);
        }
        //选项记录表插入
        long id = vp.getId();
        String[] content = vp.getContent();
        VoteItem voteItem = new VoteItem();
        for (int i = 0; i < content.length; i++) {
            voteItem.setVoteProjectId(id);
            voteItem.setVoteItemNumber(String.valueOf((char) (65 + i)));
            voteItem.setVoteItemContent(content[i]);
            voteItemService.insert(voteItem);
        }
        //文件处理
        MultipartFile[] files = voteProject.getFiles();
        String filePath = request.getSession().getServletContext().getRealPath(System.getProperty("file.separator")+"uploadFiles"+System.getProperty("file.separator"));
        for(int i=0;i<files.length;i++){
            if (!files[i].isEmpty()) {
                String uniqueName=files[i].getOriginalFilename();//得到文件名
                String uuid = UUID.randomUUID().toString().replace("-","");
                String uuidFileName = uuid +"_"+uniqueName;
                //String fileType = uniqueName.split("[.]")[1];
                //File f = new File(filePath+"/"+uuid+"."+fileType);
                try {
                    FileUtil.upFile(files[i].getInputStream(), uuidFileName, filePath);
                    com.vote.entity.File upFile = new com.vote.entity.File();
                    upFile.setFilename(uuidFileName);
                    upFile.setFilepath(filePath);
                    upFile.setVoteProjectId(id);
                    fileDao.insertSelective(upFile);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return "vote/addvotesuccess";
    }

    @RequestMapping("/manageVote")
    public String manageVote(Model model) {
        return "manager/managevote";
    }

    @RequestMapping("/voteProject/load")
    @ResponseBody
    public PageInfo<VoteProject> load(@RequestParam(required = true, defaultValue = "1") Integer page, HttpServletRequest request, Model model) {
        Map<String, Object> map = new HashMap<String, Object>();
        PageHelper.startPage(page, 10);
        PageHelper.orderBy("create_time desc");
        List<VoteProject> list = voteProjectService.findAllVote();
        PageInfo<VoteProject> p = new PageInfo<VoteProject>(list);
        p.setList(list);
        return p;
    }

    @RequestMapping("/voteProject/tab1Load")
    @ResponseBody
    public PageInfo<VoteProject> tab1Load(@RequestParam(required = true, defaultValue = "1") Integer page, HttpServletRequest request, Model model) {
        PageHelper.startPage(page, 10);
        PageHelper.orderBy("create_time desc");
        String name = (String) request.getSession().getAttribute("username");
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("name",name);
        map.put("isClose",null);
        map.put("voteTitle",null);
        map.put("voteMode",null);
        List<VoteProject>  list = voteProjectService.findNoVote(map);
        PageInfo<VoteProject> p = new PageInfo<VoteProject>(list);
        p.setList(list);
        return p;
    }

    @RequestMapping("/voteProject/tab2Load")
    @ResponseBody
    public PageInfo<VoteProject> tab2Load(@RequestParam(required = true, defaultValue = "1") Integer page, HttpServletRequest request, Model model) {
        PageHelper.startPage(page, 10);
        PageHelper.orderBy("create_time desc");
        String name = (String) request.getSession().getAttribute("username");
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("name",name);
        map.put("isClose",null);
        map.put("voteTitle",null);
        map.put("voteMode",null);
        List<VoteProject>  list = voteProjectService.findVoted(map);
        PageInfo<VoteProject> p = new PageInfo<VoteProject>(list);
        p.setList(list);
        return p;
    }
    @RequestMapping("/manageVote/search")
    @ResponseBody
    public PageInfo<VoteProject> search4manage(@RequestParam(required = true, defaultValue = "1") Integer page, String search_title, String search_mode, String search_close,HttpServletRequest request){
        PageHelper.startPage(page, 10);
        PageHelper.orderBy("create_time desc");
        HashMap<String, Object> searchParams = new HashMap<String, Object>();
        if (search_title != null && search_title.length() == 0)
            search_title = null;
        searchParams.put("voteTitle", search_title);
        searchParams.put("voteMode", Boolean.valueOf(search_mode));
        if (search_close == null) {
            searchParams.put("isClose", search_close);
        } else {
            searchParams.put("isClose", Boolean.valueOf(search_close));
        }
        List<VoteProject> list = voteProjectService.findVote(searchParams);
        PageInfo<VoteProject> p = new PageInfo<VoteProject>(list);
        p.setList(list);
        return p;
    }

    @RequestMapping("/search")
    @ResponseBody
    public PageInfo<VoteProject> search(@RequestParam(required = true, defaultValue = "1") Integer page, String search_title, String search_mode, String search_close,HttpServletRequest request) {
        PageHelper.startPage(page, 10);
        PageHelper.orderBy("create_time desc");
        HashMap<String, Object> searchParams = new HashMap<String, Object>();
        if (search_title != null && search_title.length() == 0)
            search_title = null;
        searchParams.put("voteTitle", search_title);
        searchParams.put("voteMode", Boolean.valueOf(search_mode));
        if (search_close == null) {
            searchParams.put("isClose", search_close);
        } else {
            searchParams.put("isClose", Boolean.valueOf(search_close));
        }
        String name = (String) request.getSession().getAttribute("username");
        searchParams.put("name",name);
        List<VoteProject> list = voteProjectService.findNoVote(searchParams);
        PageInfo<VoteProject> p = new PageInfo<VoteProject>(list);
        p.setList(list);
        return p;
    }

    @RequestMapping("/search1")
    @ResponseBody
    public PageInfo<VoteProject> search1(@RequestParam(required = true, defaultValue = "1") Integer page, String search_title, String search_mode, String search_close,HttpServletRequest request){
        PageHelper.startPage(page, 10);
        PageHelper.orderBy("create_time desc");
        HashMap<String, Object> searchParams = new HashMap<String, Object>();
        if (search_title != null && search_title.length() == 0)
            search_title = null;
        searchParams.put("voteTitle", search_title);
        searchParams.put("voteMode", Boolean.valueOf(search_mode));
        if (search_close == null) {
            searchParams.put("isClose", search_close);
        } else {
            searchParams.put("isClose", Boolean.valueOf(search_close));
        }
        String name = (String) request.getSession().getAttribute("username");
        searchParams.put("name",name);
        List<VoteProject> list = voteProjectService.findVoted(searchParams);
        PageInfo<VoteProject> p = new PageInfo<VoteProject>(list);
        p.setList(list);
        return p;
    }

    @RequestMapping("/delete")
    @ResponseBody
    public String delete(HttpServletRequest request) {
        long id = Long.parseLong(request.getParameter("id"));
        voteProjectService.deleteById(id);
        voteItemService.deleteByProjectId(id);
        voteDetailsService.deleteByProjectId(id);
        return request.getParameter("id");
    }

    @RequestMapping("/toUpdate")
    @ResponseBody
    public VoteProject toUpdate(long id) {
        //long id = Long.parseLong(request.getParameter("id"));
        VoteProject voteProject = voteProjectService.selectById(Long.valueOf(id));
        return voteProject;
    }

    @RequestMapping("/update")
    @ResponseBody
    public VoteProject update(HttpServletRequest request, Model model, VoteProject voteProject) {
        VoteProject voteProject1 = voteProjectService.selectById(voteProject.getId());
        voteProject1.setEndTime(voteProject.getEndTime());
        voteProject1.setVoteTitle(voteProject.getVoteTitle());
        voteProject1.setIsCheckResults(voteProject.getIsCheckResults());
        voteProject1.setIsModifyVote(voteProject.getIsModifyVote());
        voteProjectService.update(voteProject1);
        return voteProject1;
    }

    @RequestMapping("/updateConsoleDlg")
    public String updateConsoleDlg(Model model) {
        return "manager/updateconsoleDlg";
    }

    @RequestMapping("/consoleDlg")
    public String consoleDlg(Model model) {
        return "manager/voteconsoleDlg";
    }

    @RequestMapping("/showVoteDetails")
    public String showVoteDetails(Model model, String id, HttpServletRequest request) {
        long projectId = Long.valueOf(id);
        VoteProject voteProject = voteProjectService.selectById(projectId);
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        voteProject.setTime(format.format(voteProject.getEndTime()));
        String createTime = format.format(voteProject.getCreateTime());
        List<VoteItem> voteItems = voteItemService.selectByVoteProjectId(projectId);
        LinkedHashMap<String, String> contentMap = new LinkedHashMap<String, String>();
        for (VoteItem vo : voteItems) {
            contentMap.put(vo.getVoteItemNumber(), vo.getVoteItemContent());
        }
        String name = (String) request.getSession().getAttribute("username");
        VoteDetails voteDetails = voteDetailsService.selectByProjectIdAndVoter(projectId,name);
        String msg = null;
        if (voteDetails != null) {
            String[] out = AESUtil.decrypt(voteDetails.getId());
            msg = "你已投过票，上次所投选项为" + out[1];
        }
        List<com.vote.entity.File> files = fileDao.selectByVoteProjectId(projectId);
        HashMap<String,String> fileMap = new HashMap<String, String>();
        for (com.vote.entity.File file:files) {
            String path = file.getFilepath()+file.getFilename();
            fileMap.put(path,file.getFilename());
        }
        model.addAttribute("fileMap",fileMap);
        model.addAttribute("msg", msg);
        model.addAttribute("contentMap", contentMap);
        model.addAttribute("createTime",createTime);
        model.addAttribute("voteProject", voteProject);
        return "vote/votedetails";
    }

    @RequestMapping("/vote")
    public String vote(Model model, @RequestParam("content") String[] content, String id, HttpServletRequest request) {
        String name = (String) request.getSession().getAttribute("username");
        long projectId = Long.parseLong(id);
        VoteDetails voteDetail = voteDetailsService.selectByProjectIdAndVoter(projectId, name);
        VoteItem voteItem = new VoteItem();
        StringBuffer selects = new StringBuffer();
        for (String j : content) {
            selects.append(j);
            voteItem = voteItemService.selectByProjectIdAndNumber(projectId, j);
            int poll = voteItem.getVoteItemPoll();
            voteItem.setVoteItemPoll(poll + 1);
            voteItemService.update(voteItem);
        }
        if (voteDetail != null) {
            String[] out1 = AESUtil.decrypt(voteDetail.getId());
            //LogUtils.info(out1[1]);
            String[] select = {out1[1]};
            //LogUtils.info(select[0]);
            for (String i : select) {
                voteItem = voteItemService.selectByProjectIdAndNumber(projectId, i);
                //LogUtils.info(voteItem);
                int poll = voteItem.getVoteItemPoll();
                voteItem.setVoteItemPoll(poll - 1);
                voteItemService.update(voteItem);
            }
            String[] out = AESUtil.encryptAndUpdate(voteDetail.getVoterName(),selects.toString(),voteDetail.getId());
            voteDetail.setVoteTime(new Date());
            voteDetail.setVoteSelects(out[1]);
            voteDetailsService.updateByPrimaryKey(voteDetail);
        } else {
            VoteDetails voteDetails = new VoteDetails();
            voteDetails.setVoteProjectId(projectId);
            voteDetails.setVoterName(name);
            voteDetails.setVoteSelects(selects.toString());
            voteDetails.setVoteTime(new Date());
            voteDetailsService.insert(voteDetails);
            Details details = new Details();
            details.setVoteProjectId(projectId);
            details.setVoter(name);
            voteDetailsService.insert1(details);
            Long ID = voteDetails.getId();
            String[] out = AESUtil.encryptAndInsert(voteDetails.getVoterName(),voteDetails.getVoteSelects(),ID);
            voteDetails.setVoteSelects(out[1]);
            voteDetailsService.updateByPrimaryKey(voteDetails);

        }
        return "vote/votesuccess";
    }

    @RequestMapping("/showVoteResults")
    public String showVoteResults(String id, Model model, HttpServletRequest request) {
        long projectId = Long.valueOf(id);
        VoteProject voteProject = voteProjectService.selectById(projectId);
        if (voteProject.getIsCheckResults() == false && !(request.getSession().getAttribute("identity").equals("manager"))) {
            return "roleserror";
        }
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String createTime = format.format(voteProject.getCreateTime());
        voteProject.setTime(format.format(voteProject.getEndTime()));
        List<VoteItem> voteItems = voteItemService.selectByVoteProjectId(projectId);
        int sum = 0;
        for (VoteItem vo : voteItems) {
            sum += vo.getVoteItemPoll();
        }
        model.addAttribute("sum", sum);
        model.addAttribute("voteItems", voteItems);
        model.addAttribute("voteProject", voteProject);
        model.addAttribute("createTime",createTime);
        return "vote/showvoteresults";
    }

    @RequestMapping("/showVoteProjectDetails")
    public String showVoteProjectDetails(String id, Model model, HttpServletRequest request){
        long projectId = Long.parseLong(id);
        VoteProject voteProject = voteProjectService.selectById(projectId);
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        voteProject.setTime(format.format(voteProject.getEndTime()));
        String createTime = format.format(voteProject.getCreateTime());
        List<VoteItem> voteItems = voteItemService.selectByVoteProjectId(projectId);
        LinkedHashMap<String, String> contentMap = new LinkedHashMap<String, String>();
        for (VoteItem vo : voteItems) {
            contentMap.put(vo.getVoteItemNumber(), vo.getVoteItemContent());
        }
        String name = (String) request.getSession().getAttribute("username");
        VoteDetails voteDetails = voteDetailsService.selectByProjectIdAndVoter(projectId, name);
        String msg = null;
        if (voteDetails != null) {
            String[] out = AESUtil.decrypt(voteDetails.getId());
            msg = "你已投过票，上次所投选项为" + out[1];
        }
        List<com.vote.entity.File> files = fileDao.selectByVoteProjectId(projectId);
        HashMap<String,String> fileMap = new HashMap<String, String>();
        for (com.vote.entity.File file:files) {
            String path = file.getFilepath()+file.getFilename();
            fileMap.put(path,file.getFilename());
        }
        model.addAttribute("fileMap",fileMap);
        model.addAttribute("msg", msg);
        model.addAttribute("contentMap", contentMap);
        model.addAttribute("createTime",createTime);
        model.addAttribute("voteProject", voteProject);
        return "vote/voteprojectdetails";
    }

    @RequestMapping("/sentRemindEmail")
    @ResponseBody
    public CommonResult<String> sentRemindEmail(String id, String name){
        long projectId = Long.parseLong(id);
        String title=voteProjectService.selectById(projectId).getVoteTitle();
        try {
            User user=userService.selectUserByName(name);
            if(user!=null)
                MailUtil.sendRemindEmail(title,user.getEmail());
            else {
                Manager manager=managerService.selectManagerByName(name);
                MailUtil.sendRemindEmail(title,manager.getEmail());
            }
        }catch (Exception e){
            return new CommonResult<String>("1");
        }
        return new CommonResult<String>("0");
    }



    @RequestMapping("/showWhoVotes")
    public String showWhoVotes(String id, Model model, HttpServletRequest request) {
        long projectId = Long.valueOf(id);
        List<User> allUser=userService.findAllUser();
        List<Manager>allManagers =managerService.selectManager();
        Set<String> names= new HashSet<String>();
        for(User user:allUser){
            names.add(user.getName());
        }
        for(Manager manager:allManagers){
            names.add(manager.getName());
        }
        List<VoteDetails>allVoteDetails=voteDetailsService.findByProjectId(projectId);
        for(VoteDetails voteDetails:allVoteDetails){
            if(names.contains(voteDetails.getVoterName())){
                names.remove(voteDetails.getVoterName());
            }
        }
        model.addAttribute("whoHasNotVote", names);
        return "vote/showWhoVotes";
    }
}
