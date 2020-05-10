package lxiian.plugin.show3d;

import android.app.Activity;
import android.os.Bundle;
import android.text.TextUtils;

import androidx.annotation.Nullable;

import lxiian.plugin.show3d.easyshow3d.ModelFactory;
import lxiian.plugin.show3d.easyshow3d.bean.ModelObject;
import lxiian.plugin.show3d.easyshow3d.imp.ModelLoaderListener;
import lxiian.plugin.show3d.easyshow3d.view.ShowModelView;

public class Show3DActivity extends Activity {

    ShowModelView showModelView;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_show_3d);

        findView();
        initData();
    }

    private void findView() {
        showModelView = findViewById(R.id.show_3d_view);
    }

    private void initData() {
        String path = getIntent().getStringExtra("path");

        if(TextUtils.isEmpty(path))
            return;

        ModelFactory.decodeFile(this, path, new ModelLoaderListener() {
            @Override
            public void loadBegin() {
            }

            @Override
            public void loadedUpdate(float progress) {
            }

            @Override
            public void loadedFinish(ModelObject modelObject) {
                if(modelObject != null)
                    showModelView.setModelObject(modelObject);
            }

            @Override
            public void loaderCancel() {
            }

            @Override
            public void loaderFailure() {
            }
        });
    }

}
