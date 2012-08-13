#include <stdlib.h>
#include <stdio.h>
//导入AS3包
#include "AS3.h"

//冒泡排序
void BubbleSort(int *array, int array_size)
{
  int tmp;
  int bound = array_size; 
  int i;
  while (bound > 1)
  {
	for (i = 0; i < bound - 1; i++)
	{
        if (array[i] > array[i + 1]) 
        { 
            tmp = array[i]; 
            array[i] = array[i + 1]; 
            array[i + 1] = tmp;
        } 
    }
    bound--; 
  }
}

static AS3_Val sort(void* self, AS3_Val args)
{
	//获得传进来的数组
	AS3_Val asArray = NULL;
    AS3_ArrayValue(args, "AS3ValType", &asArray);
    // 得到 Array 的shift方法
    AS3_Val shift_function = AS3_GetS(asArray, "shift");
	//得到数组的长度
	AS3_Val actionscript_array_size =  AS3_GetS(asArray, "length");
    int array_size = AS3_IntValue(actionscript_array_size);
	//创建一个c语言的数组
	int val[array_size];
    // 调用上面得到的方法把as3数组转为c语言的数组
	int i;
	AS3_Val emptyParams = AS3_Array("");
    for(i = 0; i < array_size; i++)
    {
		//执行AS3的方法，第一个参数为方法名，第二个参数为方法对应的对象，第三个为方法参数数组
        AS3_Val temp_actionscript_Int = AS3_Call(shift_function, asArray, emptyParams);
        int tmp = AS3_IntValue(temp_actionscript_Int);
		val[i] = tmp;
        AS3_Release(temp_actionscript_Int);
    }
    AS3_Release(shift_function);
	//开始排序
	BubbleSort(val,array_size);
	//将排好序的数组转为as3的数组
	//获得数组的PUSH方法
	AS3_Val push_function = AS3_GetS(asArray, "push");
    int j;
    for( j = 0; j < array_size ; j++)
	{
		AS3_Val int_to_push = AS3_Array("IntType", val[j]);
        AS3_Call(push_function, asArray, int_to_push );
        AS3_Release(int_to_push);
    }
    AS3_Release(push_function);
	return asArray;
}

int main()
{
	//创建一个同步的回调函数对象，第一个参数为函数的状态，第二个参数是函数
	AS3_Val sortTest = AS3_Function( NULL, sort );

	// 创建一个持有函数引用的对象
	AS3_Val result = AS3_Object( "sort:AS3ValType", sortTest);

	// 释放计数器
	AS3_Release( sortTest );

	// 该方法告知虚拟机你的库已经初始化完毕，参数是对象,包含你的库函数
	// 这个函数不会返回,所以该函数后不需要写代码。如果C里面不调用该函数,虚拟机不会执行任何C以外的代码
	AS3_LibInit( result );

	// should never get here!
	return 0;
}