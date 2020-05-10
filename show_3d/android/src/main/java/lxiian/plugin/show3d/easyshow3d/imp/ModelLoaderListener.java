package lxiian.plugin.show3d.easyshow3d.imp;

import lxiian.plugin.show3d.easyshow3d.bean.ModelObject;

public interface ModelLoaderListener {

    void loadBegin();

    void loadedUpdate(float progress);

    void loadedFinish(ModelObject modelObject);

    void loaderCancel();

    void loaderFailure();
}
