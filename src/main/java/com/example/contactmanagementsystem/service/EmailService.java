package com.example.contactmanagementsystem.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;

@Service
@Slf4j
public class EmailService {
    private final JavaMailSender javaMailSender;
    @Value("${mail.from.email}")
    private String fromEmail;
    @Value("${mail.from.name}")
    private String fromName;

    @Autowired
    public EmailService(JavaMailSender javaMailSender) {
        this.javaMailSender = javaMailSender;
    }

    public void sendEmailToUser(String recipientEmail, String subject, String body){
        MimeMessage message = javaMailSender.createMimeMessage();
        MimeMessageHelper helper=new MimeMessageHelper(message);

        try {
            helper.setTo(recipientEmail);
            helper.setSubject(subject);
            helper.setText(body,true);
            helper.setFrom(new InternetAddress(fromEmail,fromName));

        } catch (MessagingException | UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
        javaMailSender.send(message);
        log.info("Mail Sent to {}",recipientEmail);
    }

}
