package common;

/**
 * Created by wh on 2018/5/28.
 */
public class CommonResult<T> {
    public final static String SUCCESS = "0";
    public final static String ERROR_PASSWD = "1";
    /**
     * 操作是否成功
     */
    private String errno;
    /**
     * 操作结果信息，主要用来存储操作失败时对异常信息做出的提示信息
     */
    private String errorMsg;
    /**
     * 操作结果数据集，用来存储要返回给前端的数据，可以是对象.集合等等
     */
    private T data;

    public CommonResult(String errno) {
        this.errno = errno;
    }

    public CommonResult(String errno, T data) {
        this.errno = errno;
        this.data = data;
    }

    public CommonResult(String errno, String errorMsg) {
        this.errno = errno;
        this.errorMsg = errorMsg;
    }

    public String getErrno() {
        return errno;
    }

    public void setErrno(String errno) {
        this.errno = errno;
    }

    public String getErrorMsg() {
        return errorMsg;
    }

    public void setErrorMsg(String errorMsg) {
        this.errorMsg = errorMsg;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
