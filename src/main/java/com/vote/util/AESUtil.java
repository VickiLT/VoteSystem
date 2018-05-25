package com.vote.util;

import com.vote.entity.Key;
import com.vote.service.Impl.KeyServiceImpl;
import com.vote.service.KeyService;
import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Created by sunwe on 2018/4/13.
 */
@Component
public class AESUtil {
    private static final String KEY_ALGORITHM = "AES";
    private static final String DEFAULT_CIPHER_ALGORITHM = "AES/ECB/PKCS5Padding";//默认的加密算法
    public static AESUtil aesUtil;
    @Autowired
    private KeyService keyService;

    @PostConstruct
    public void init() {
        aesUtil = this;
    }
    /**
     * AES加密
     * @param content1
     * @param content2
     * @param ID
     * @return
     */
    public static String[] encryptAndInsert(String content1,String content2, Long ID) {
        try {
            String R1 = UUID.randomUUID().toString().replace("-","");
            String R2 = UUID.randomUUID().toString().replace("-","").substring(16);
            char[] array = R1.toCharArray();
            for(int i=0;i<array.length;i++) //遍历字符数组
            {
                array[i]=(char)(array[i]^ID); //对每个数组元素进行异或运算
            }
            String R3 = new String(array);
            Cipher cipher = Cipher.getInstance(DEFAULT_CIPHER_ALGORITHM);// 创建密码器

            byte[] byteContent = R2.getBytes("utf-8");

            cipher.init(Cipher.ENCRYPT_MODE, getSecretKey(R3));// 初始化为加密模式的密码器

            byte[] out1 = new byte[32];
            byte[] out2 = new byte[32];
            byte[] result = cipher.doFinal(byteContent);// 加密
            byte[] contents1 = content1.getBytes();
            byte[] contents2 = content2.getBytes();
            for (int i = 0; i < result.length; i++) {
                out1[i] = (byte) (result[i] ^ contents1[i % contents1.length]);
            }
            for (int i = 0; i < result.length; i++) {
                out2[i] = (byte) (result[i] ^ contents2[i % contents2.length]);
            }
            String[] out = new String[2];
            out[0] = Base64.encodeBase64String(out1);
            out[1] = Base64.encodeBase64String(out2);
            //System.out.println(R1+" "+R2);
            Key key = new Key();
            key.setVoteDetailsId(ID);
            key.setR1(R1);
            key.setR2(R2);
            key.setEt1(Base64.encodeBase64String(out1));
            key.setEt2(Base64.encodeBase64String(out2));
            key.setNum1(contents1.length);
            key.setNum2(contents2.length);
            aesUtil.keyService.insert(key);
            return out;
        } catch (Exception ex) {
            Logger.getLogger(AESUtil.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

    /**
     *
     * @param content1
     * @param content2
     * @param ID
     * @return
     */
    public static String[] encryptAndUpdate(String content1,String content2, Long ID) {
        try {
            String R1 = UUID.randomUUID().toString().replace("-","");
            String R2 = UUID.randomUUID().toString().replace("-","").substring(16);
            char[] array = R1.toCharArray();
            for(int i=0;i<array.length;i++) //遍历字符数组
            {
                array[i]=(char)(array[i]^ID); //对每个数组元素进行异或运算
            }
            String R3 = new String(array);
            Cipher cipher = Cipher.getInstance(DEFAULT_CIPHER_ALGORITHM);// 创建密码器

            byte[] byteContent = R2.getBytes("utf-8");

            cipher.init(Cipher.ENCRYPT_MODE, getSecretKey(R3));// 初始化为加密模式的密码器

            byte[] out1 = new byte[32];
            byte[] out2 = new byte[32];
            byte[] result = cipher.doFinal(byteContent);// 加密
            byte[] contents1 = content1.getBytes();
            byte[] contents2 = content2.getBytes();
            for (int i = 0; i < result.length; i++) {
                out1[i] = (byte) (result[i] ^ contents1[i % contents1.length]);
            }
            for (int i = 0; i < result.length; i++) {
                out2[i] = (byte) (result[i] ^ contents2[i % contents2.length]);
            }
            String[] out = new String[2];
            out[0] = Base64.encodeBase64String(out1);
            out[1] = Base64.encodeBase64String(out2);
            //System.out.println(R1+" "+R2);
            Key key = new Key();
            key.setVoteDetailsId(ID);
            key.setR1(R1);
            key.setR2(R2);
            key.setEt1(Base64.encodeBase64String(out1));
            key.setEt2(Base64.encodeBase64String(out2));
            key.setNum1(contents1.length);
            key.setNum2(contents2.length);
            aesUtil.keyService.updateByPrimaryKeySelective(key);
            return out;
        } catch (Exception ex) {
            Logger.getLogger(AESUtil.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

    /**
     * AES解密
     * @param ID
     * @return
     */
    public static String[] decrypt(Long ID) {

        Key key = aesUtil.keyService.selectByVoteId(ID);
        String ET1 = key.getEt1();
        String R1 = key.getR1();
        String R2 = key.getR2();
        int num1 = key.getNum1();
        String ET2 = key.getEt2();
        int num2 = key.getNum2();
        try {
            char[] array = R1.toCharArray();
            for(int i=0;i<array.length;i++) //遍历字符数组
            {
                array[i]=(char)(array[i]^ID); //对每个数组元素进行异或运算
            }
            String R3 = new String(array);
            Cipher cipher = Cipher.getInstance(DEFAULT_CIPHER_ALGORITHM);// 创建密码器

            byte[] byteContent = R2.getBytes("utf-8");

            cipher.init(Cipher.ENCRYPT_MODE, getSecretKey(R3));// 初始化为加密模式的密码器
            String[] out = new String[2];
            byte[] EW1 = new byte[num1];
            byte[] EW2 = new byte[num2];
            byte[] EW3 = new byte[32];
            byte[] EW4 = new byte[32];
            byte[] ETs1 =  Base64.decodeBase64(ET1);
            byte[] ETs2 = Base64.decodeBase64(ET2);
            byte[] result = cipher.doFinal(byteContent);// 加密
            for (int i = 0; i < result.length; i++) {
                EW3[i] = (byte) (result[i] ^ ETs1[i % ETs1.length]);
            }
            for (int i = 0; i < result.length; i++) {
                EW4[i] = (byte) (result[i] ^ ETs2[i % ETs2.length]);
            }
            System.arraycopy(EW3, 0, EW1, 0, num1);
            System.arraycopy(EW4, 0, EW2, 0, num2);
            out[0] = new String(EW1);
            out[1] = new String(EW2);
            return out;
        } catch (Exception ex) {
            Logger.getLogger(AESUtil.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

    /**
     * 生成加密秘钥
     *
     * @return
     */
    private static SecretKeySpec getSecretKey(final String password) throws UnsupportedEncodingException {
        //返回生成指定算法密钥生成器的 KeyGenerator 对象
        KeyGenerator kg = null;

        try {
            kg = KeyGenerator.getInstance(KEY_ALGORITHM);

            //AES 要求密钥长度为 128
            SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG");
            secureRandom.setSeed(password.getBytes("utf-8"));
            kg.init(128,secureRandom);
            //生成一个密钥
            SecretKey secretKey = kg.generateKey();

            return new SecretKeySpec(secretKey.getEncoded(), KEY_ALGORITHM);// 转换为AES专用密钥
        } catch (NoSuchAlgorithmException ex) {

        }

        return null;
    }
}
