package kr.spring.member.service;

import kr.spring.member.vo.MailVO;

public interface SendEmailService{
    public MailVO createMailAndChangePassword(String mem_email, String mem_name, String mem_id);
    public void updatePassword(String str,String mem_email,String mem_name,String mem_id);
    public String getTempPassword();    
    public void mailSend(MailVO vo);
}