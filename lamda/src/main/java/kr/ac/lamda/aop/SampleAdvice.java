package kr.ac.lamda.aop;

import java.util.Arrays;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.EnableMBeanExport;
import org.springframework.stereotype.Component;

@Component 
@Aspect
public class SampleAdvice {

  private static final Logger logger = LoggerFactory.getLogger(SampleAdvice.class);

 // @Before("execution(* kr.ac.lamda.service.MessageService*.*(..))")
  public void startLog(JoinPoint jp) {

    logger.info("-------------startLog---------------");
    logger.info("-------------startLog---------------");
    logger.info(Arrays.toString(jp.getArgs()));
    
//	Date start = new Date();

  }
  
//@After("execution(* kr.ac.lamda.service.MessageService*.*(..))")
public void EndLog(JoinPoint jp) {

  logger.info("-------------EndLog---------------");
  logger.info("-------------EndLog---------------");
  logger.info(Arrays.toString(jp.getArgs()));

  
//System.out.println(vo);
//Date end = new Date();

//System.out.println(end.getSeconds() -  start.getSeconds());
}
  

@Around("execution(* kr.ac.lamda.service.MessageService*.*(..))") 
  public Object timeLog(ProceedingJoinPoint pjp)throws Throwable{
    
    long startTime = System.currentTimeMillis();
    logger.info(Arrays.toString(pjp.getArgs()));
    
    Object result = pjp.proceed();
    
    long endTime = System.currentTimeMillis();
    logger.info( pjp.getSignature().getName()+ " : " + (endTime - startTime) );
    logger.info("=============================================");
    
    return result;
  }   

}
