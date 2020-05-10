package lxiian.plugin.show3d.easyshow3d.thread;

public interface IAnalysisFinishCallback {
    void verticeProgressUpdate(int threadID, int nums);
    void faceProgressUpdate(int threadID, int nums);
    void alvFinish();
    void alvFaceFinish();
}