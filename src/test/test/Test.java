import com.vote.util.MD5Util;

/**
 * Created by sunwe on 2018/4/11.
 */
public class Test {
    public static void main(String[] args) {
        String plaintest = "123";
        String s = MD5Util.generate(plaintest);
        System.out.println("密文："+ MD5Util.generate(plaintest));
        System.out.println(MD5Util.verify(plaintest,s));
    }
}
