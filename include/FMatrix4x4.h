#pragma once

#include <smmintrin.h>
#include <iostream>

#include "Standard.h"
#include "FVector.h"

namespace FRSML {
	class TFAPI Matrix4 {
	public:
		Matrix4(float** rowContent);
		Matrix4(float* row1, float* row2, float* row3, float* row4);
		Matrix4(float n = 0);
		Matrix4(vec4 row1, vec4 row2, vec4 row3, vec4 row4);

		bool IsMatrixIndentiy();

		Matrix4 Transpose();
		float Determinant();

		//Wrapper to return the member number of Matrix
		struct Matrix4Proxy
		{
			Matrix4* matrix;
			int matrixIndex1;

			Matrix4Proxy(Matrix4 *mat, int i) : matrix(mat), matrixIndex1(i) {}

			//I do not feel sastified with this :-(
			float& operator [](std::size_t matrixIndex2)
			{
				return matrix->rows[matrixIndex1].MainVector().m128_f32[3 - matrixIndex2];
			}

		};

		//Return the number given by its position
		Matrix4Proxy operator[](std::size_t i) {
			return Matrix4Proxy(this, i);
		}

		//Very sad that this method is o(n^3), but i can just understand this max.
		Matrix4 Inverse();
		
		
		inline Matrix4 operator *(Matrix4 _para);
		inline Matrix4 operator +(Matrix4 _para);
		inline Matrix4 operator -(Matrix4 _para);

	private:
		vec4 rows[4] = {};
		vec4 cols[4] = {};


	};


	static Matrix4 Identity{
		{ 1,0,0,0 },
		{ 0,1,0,0 },
		{ 0,0,1,0 },
		{ 0,0,0,1 }
	};

	static Matrix4 Zero{
		{ 0,0,0,0 },
		{ 0,0,0,0 },
		{ 0,0,0,0 },
		{ 0,0,0,0 }
	};

	TFAPI Matrix4 CreatePerspectiveMatrix(float zoom,
		vec2 extent,
		float zNear,
		float zFar);

	TFAPI Matrix4 CreateOrthoMatrix(float left,
		float right, float bottom,
		float top, float zNear, float zFar);

	//I have the up vector already.
	TFAPI Matrix4 LookAt(vec3 camPos, vec3 camTarget);

	TFAPI std::ostream& operator <<(std::ostream&, Matrix4);
};