/*
 * Created by Michal on 06/03/2017.
 */
package com.michal.animalvision.filter;

import android.content.Context;
import android.opengl.GLES20;

import com.michal.animalvision.MyGLUtils;
import com.michal.animalvision.R;

/**
 * Created by Michal on 06/03/2017.
 */

public class Octopus extends CameraFilter {
    private int program;

    public Octopus(Context context) {
        super(context);

        // Build shaders
        program = MyGLUtils.buildProgram(context, R.raw.vertext, R.raw.bird);
    }

    @Override
    public void onDraw(int cameraTexId, int canvasWidth, int canvasHeight) {
        setupShaderInputs(program,
                new int[]{canvasWidth, canvasHeight},
                new int[]{cameraTexId},
                new int[][]{});
        GLES20.glDrawArrays(GLES20.GL_TRIANGLE_STRIP, 0, 4);
    }
}
