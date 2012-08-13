#include <stdlib.h>
#include <stdio.h>
//����AS3��
#include "AS3.h"

//ð������
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
	//��ô�����������
	AS3_Val asArray = NULL;
    AS3_ArrayValue(args, "AS3ValType", &asArray);
    // �õ� Array ��shift����
    AS3_Val shift_function = AS3_GetS(asArray, "shift");
	//�õ�����ĳ���
	AS3_Val actionscript_array_size =  AS3_GetS(asArray, "length");
    int array_size = AS3_IntValue(actionscript_array_size);
	//����һ��c���Ե�����
	int val[array_size];
    // ��������õ��ķ�����as3����תΪc���Ե�����
	int i;
	AS3_Val emptyParams = AS3_Array("");
    for(i = 0; i < array_size; i++)
    {
		//ִ��AS3�ķ�������һ������Ϊ���������ڶ�������Ϊ������Ӧ�Ķ��󣬵�����Ϊ������������
        AS3_Val temp_actionscript_Int = AS3_Call(shift_function, asArray, emptyParams);
        int tmp = AS3_IntValue(temp_actionscript_Int);
		val[i] = tmp;
        AS3_Release(temp_actionscript_Int);
    }
    AS3_Release(shift_function);
	//��ʼ����
	BubbleSort(val,array_size);
	//���ź��������תΪas3������
	//��������PUSH����
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
	//����һ��ͬ���Ļص��������󣬵�һ������Ϊ������״̬���ڶ��������Ǻ���
	AS3_Val sortTest = AS3_Function( NULL, sort );

	// ����һ�����к������õĶ���
	AS3_Val result = AS3_Object( "sort:AS3ValType", sortTest);

	// �ͷż�����
	AS3_Release( sortTest );

	// �÷�����֪�������Ŀ��Ѿ���ʼ����ϣ������Ƕ���,������Ŀ⺯��
	// ����������᷵��,���Ըú�������Ҫд���롣���C���治���øú���,���������ִ���κ�C����Ĵ���
	AS3_LibInit( result );

	// should never get here!
	return 0;
}