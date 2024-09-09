#### GLSurfaceView

```java
mGlSurfaceView = (GLSurfaceView)mView;
//设置版本
mGlSurfaceView.setEGLContextClientVersion(2);
//设置GLSurfaceView.Render
mGlSurfaceView.setRenderer(new CarplayScreenRender());
//设置渲染模式
mGlSurfaceView.setRenderMode(GLSurfaceView.RENDERMODE_WHEN_DIRTY);
//添加SurfaceHolder的callback
mGlSurfaceView.getHolder().addCallback(new SurfaceHolderCallback());
```

###### 渲染模式

RENDERMODE_WHEN_DIRTY

> `Renderer` 的 `onDrawFrame()` 方法只有在视图明确请求时才会被调用。通常是在调用 `requestRender()` 方法时触发。

RENDERMODE_CONTINUOUSLY

> `onDrawFrame()` 方法会不断地被调用，频率尽可能地快。这会导致显示内容持续更新，类似于游戏循环。



##### SurfaceHolder

`SurfaceHolder` 是 `SurfaceView` 的核心组件，提供了对底层 `Surface` 的控制，允许在 `SurfaceView` 上进行高效的绘图和视频处理操作。

###### SurfaceHolder.Callback

管理SurfaceView的生命周期，在主线程

```Java
    private final SurfaceHolder.Callback callback = new SurfaceHolder.Callback() {
        @Override
        public void surfaceCreated(@NonNull SurfaceHolder surfaceHolder) {
            //做一些初始化的工作，比如保持屏幕打开
        }

        @Override
        public void surfaceChanged(@NonNull SurfaceHolder surfaceHolder, int format, int width, int height) {
			//SurfaceView的格式和大小发生变化时调用，在这里请求视频流。
        }

        @Override
        public void surfaceDestroyed(@NonNull SurfaceHolder surfaceHolder) {
			//通知停止推流
        }
    };
```



##### Render

渲染

###### GLSurfaceView.Render

```java
    private class ScreenRender implements GLSurfaceView.Renderer {
        
        private GLDirectDrawer mDirectDrawer = null;
        
        private int genTextureID()  {
            int[] texture = new int[1];
            GLES20.glGenTextures(1, texture, 0);
            GLES20.glBindTexture(GLES11Ext.GL_TEXTURE_EXTERNAL_OES, texture[0]);
            return texture[0];
        }

        @Override
        public void onSurfaceCreated(GL10 gl, EGLConfig config) {
            LogPrint.Info(TAG, "GL onSurfaceCreated");
            //1.构建SurfaceTexture
            
            mDirectDrawer = new GLDirectDrawer();
            mDirectDrawer.SetCropArea(0, 0,
                    mRemoteScrWidth, mRemoteScrHeight);
            mSurfaceTexture.attachToGLContext(genTextureID());
        }

        @Override
        public void onSurfaceChanged(GL10 gl, int width, int height) {
            LogPrint.Info(TAG, "GL onSurfaceChanged width ="+ width + " height =" + height);
            GLES20.glViewport(0, 0, width, height);
        }

        @Override
        public void onDrawFrame(GL10 gl) {
            if (mCodecScrHeight > 0 || mCodecScrWidth > 0) {
                mDirectDrawer.setCodecCropArea(
                        mCodecScrWidth, mCodecScrHeight);
                mCodecScrHeight = 0;
                mCodecScrWidth = 0;
            }
            try {
                mSurfaceTexture.updateTexImage();
                mDirectDrawer.DrawTexture();
            } catch (Exception e) {
                LogPrint.Error("onDrawFrame Error !");
                e.printStackTrace();
            }
        }
    }
```



##### SurfaceTexture

`SurfaceTexture` 通常与 `GLSurfaceView` 一起使用，用于在 GLSurfaceView 上渲染动态的图像内容。例如，从摄像头获取的实时视频流可以通过 `SurfaceTexture` 渲染到 GLSurfaceView 上。

```java
mSurfaceTexture = new SurfaceTexture(false);
mSurfaceTexture.setOnFrameAvailableListener(surfaceTexture -> {
	if (mGlSurfaceView != null) {
		mGlSurfaceView.requestRender();
	}
});
```

###### 函数-updateTexImage

在更新内部图像缓冲区的时候调用，作用是绑定最新的图像数据到OpenGL纹理中，在渲染循环中（如在 `GLSurfaceView.Renderer` 的 `onDrawFrame()` 方法中）调用。

###### 函数-attachToGLContext

用于将 `SurfaceTexture` 绑定到一个现有的 OpenGL ES 纹理对象中，使得图像数据可以通过该纹理对象进行渲染。

> TextureID

```java
private int genTextureID() {
	int[] texture = new int[1];
	//生成一个纹理id，放到texture数组里，0代表偏移量，从0个元素开始存储id
	GLES20.glGenTextures(1, texture, 0);
    //将纹理ID绑定到纹理目标上，GL_TEXTURE_EXTERNAL_OES用于从外部资源获取图像信息
	GLES20.glBindTexture(GLES11Ext.GL_TEXTURE_EXTERNAL_OES, texture[0]);
	return texture[0];
}
```

