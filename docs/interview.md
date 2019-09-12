# Interview questions

# C

```
#include <stdio.h>
#include <stdlib.h>
#include <time.h>


char* intToStr(int x)
{
    char buf[4];
    sprintf(buf, "%d", x);
    return buf;
}

int main(int argc, char *argv[])
{
    srand(time(NULL));

    int a = rand() % 10500; // 3456

    printf("Hello world!\n");

    char *str = intToStr(a);
    printf("Integer is %s\n", str);

    return str != NULL ? 0 : 1;
}
```

## Algorithms and data structures

Вопросы:
1. С помощью какой структуры данных оптимальные всего реализовать очередь с приоритетами?
2. Напишите пример бинарной пирамиды?
3. Чем двоичное дерево поиска отличается от бинарной пирамиды?
4. Какие проблемы есть у двоичного дерева поиска? Какие улучшения существуют?
5. Какие методы сортировки знаете?
6. Как устроен std::map? Чем отличается от std::unordered_map?
7. Как устроена хэш-таблица?
8. Задачка на DP.

### Sort algorithms

| Algorithm                 | Worst                | Expected                      | Comment            |
|---------------------------| -------------------- | ------------------------------|--------------------|
| Insertion sort (вставкой) | &#1012;(n^2)         | &#1012;(n^2)                  |                    |
| Merge sort (слиянием)     | &#1012;(n*lg(n))     | &#1012;(n*lg(n)               | Used for lists.    |
| Heap sort (пирамидальная) | O(n*lg(n))           |  -                            |                    |
| Quick sort (быстрая)      | &#1012;(n^2)         | &#1012;(n*lg(n) (ожидаемое)   |                    |
| Counting sort (подсчетом) | &#1012;(k + n)       | &#1012;(k + n)                |                    |
| Radix sort (поразрядная)  | &#1012;(d * (k + n)) | &#1012;(d * (k + n))          |                    |
| Bucket sort (карманная)   | &#1012;(n^2)         | &#1012;(n) (в среднем случае) |                    |

#### Heap sort

##### Heap
Куча является максимально эффективной реализацией абстрактного типа данных, который называется очередью с приоритетом. 

![Img. 1 Heap](images/heap.png "Max-heap")

heap_size - number of correct elements in array
legnth - number of elements in heap

0 <= A.heap-size <= A.length


```
Parent(i)
	return ⌊i/2⌋;

Left(i)
	return 2i;

Right(i)
	return 2i + 1;
```

##### Max_Heapify

i - node which breaks property of non-increasing heap

Complexity: O(lg(n))
```
Max_Heapify(A, i)
	l = Left(i)
	r = Right(i)
	
	if l <= A.heap_size and A[l] > A[i]
		largest = l
	else
		largest = i

	if r <= A.heap_size and A[r] > A[largest]
		largest = r

	if largest != i
		swap(A[i], A[largest])
		Max_Heapify(A, largest)
```

##### Build_Max_Heap

```
Build_Max_Heap(A)
	A.heap_size = A.length
	for i = ⌊A.length / 2⌋ downto 1
		Max_Heapify(A, i)
```

##### Heapsort

```
Heapsort(A)
	Build_Max_Heap(A)
	for i = A.length downto 2
		swap(A[1], A[i])
		A.heap_size = A.heap_size - 1
		Max_Heapify(A, 1)
```

#### Quick sort

```
Quicksort(A, p, r)
	if p < r
		q = Partition(A, p, r)
		Quicksort(A, p, q - 1)
		Quicksort(A, q + 1, r)
```

```
Partition(A, p, r)
	x = A[r]
	i = p - 1
	for j = p to r - 1
		if A[j] <= x
			i = i + 1
			swap(A[i], A[j])
	swap(A[i + 1], A[r])
	return i + 1
```
r - pivot element (опорный)
Invariant:
1. if p <= k <= i, then A[k] <= x
2. if i + 1 <= k <= j - 1, then A[k] > x
3. if k == r, then A[k] == x.


### Priority queue

Insert(S, x)
Maximum(S)
Extract-Max(S)
Increase-Key(S, x, k)

```
Heap-Maximum(A)
	return A[1]
```

```
Heap-Extract-Max(A)
	if A.heap-size < 1
		error "Empty queue"
	max = A[1]
	A[1] = A[A.heap-size]
	A.heap-size = A.heap-size - 1
	Max-Heapify(A,1)
	return max
```

```
Heap-Increase-Key(A, i, key)
	if key < A[i]
		error "New key is less than current"
	A[i] = key
	while i > 1 and A[Parent(i)] < A[i]
		swap(A[i], A[Parent(i)])
		i = Parent(i)
```

```
Max-Heap-Insert(A, key)
	A.heap-size = A.heap-size + 1
	A[A.heap-size] = -inf
	Heap-Increase-Key(A, A.heap-size, key)
```

## C / C++

1. Как удалить элемент из односвязного списка, если нет указателя на начало?
2. Основные принципы ООП?
3. Чем ABI отличается от API?
Application Binary Interface - an interface between two binary program modules. An ABI defines how data structures or computational routines are accessed in machine code, which is a low-level, hardware-dependent format.
ABI can be affected by:
- Calling convention
- Exception handling
- Name mangling
- C++ runtime
- Binary representation of types
- vtable layout
- inheritance, namespaces, overloading
4. What is ABI compatability? What is source compatability?


## Multi-threaded programming

1. Что такое поток? Что такое процесс? Чем они отличаются?
2. Что такое состояние гонки (неопределенность параллелизама, race condition)? Приведите пример.
3. Что такое dead lock?
4. Решите проблему producer-consumer.

### Race condition

| Thread 1       | Thread 2       |   | Integer value |
|----------------|----------------|---|---------------|
|                |                |   | 0             |
| read value     |		          | ← | 0             |
| increase value |			      |   | 0             |
| write back     |                | → | 1             |
|                | read value     |	← | 1             |
|                | increase value |   |	1             |
|                | write back     | → | 2             |

Version 1.


| Thread 1       | Thread 2       |   | Integer value |
|----------------|----------------|---|---------------|
|                |                |   | 0             |
| read value     |		          | ← | 0             |
|                | read value     |	← | 0             |
| increase value |			      |   | 0             |
|                | increase value |   |	0             |
| write back     |                | → | 1             |
|                | write back     | → | 1             |

Version 2.


### Producer-consumer example

```
semaphore fillCount = 0; // items produced
semaphore emptyCount = BUFFER_SIZE; // remaining space

procedure producer() 
{
    while (true) 
    {
        item = produceItem();
        down(emptyCount);
        putItemIntoBuffer(item);
        up(fillCount);
    }
}

procedure consumer() 
{
    while (true) 
    {
        down(fillCount);
        item = removeItemFromBuffer();
        up(emptyCount);
        consumeItem(item);
    }
}
```

Multiple producers:
```
mutex buffer_mutex; // similar to "semaphore buffer_mutex = 1", but different (see notes below)
semaphore fillCount = 0;
semaphore emptyCount = BUFFER_SIZE;

procedure producer() 
{
    while (true) 
    {
        item = produceItem();
        down(emptyCount);
        down(buffer_mutex);
        putItemIntoBuffer(item);
        up(buffer_mutex);
        up(fillCount);
    }
}

procedure consumer() 
{
    while (true) 
    {
        down(fillCount);
        down(buffer_mutex);
        item = removeItemFromBuffer();
        up(buffer_mutex);
        up(emptyCount);
        consumeItem(item);
    }
}
```

## IPC

1. Какие механизмы IPC знаете?

	* Message Passing
	* Synchronization
	* Shared memory
	* RPC

## Compilers
1. Как работает компилятор? Фазы компиляции.
2. Фазы генерации кода? Выбор инструкций, распределение регистров, выбор порядка вычислений, генерация кода.
3. Какие оптимизации знаете?
4. Что такое SSA form и зачем она нужна?
5. Dominator?
"A" strictly dominates a different node B in the control flow graph if it is impossible to reach B without passing through A first.
"A" dominates B (B is dominated by A) if either A strictly dominates B or A = B.
6. Dominance frontier?
The dominance frontier of a node d is the set of all nodes n such that d dominates an immediate predecessor of n, but d does not strictly dominate n. It is the set of nodes where d's dominance stops.
Dominance frontiers capture the precise places at which we need Φ functions.

### Optimizations

Loop optimizations

* LICM
* Loop unrolling

Data-flow optimizations

* CSE
* Constant folding

SSA-based

* Constant propagation
* DCE
* GVN

Other

* Inlining
* DCE


## Object-oriented design
1. Паттерны проектирования. Какие знаете?
Creational:

	* Abstract factory
	* Builder
	* Singleton

2. Имплементируйте singleton на C++.
```
class OnlyOne
{
public:
        static OnlyOne& Instance()
        {
                static OnlyOne theSingleInstance;
                return theSingleInstance;
        }
private:        
        OnlyOne(){};
        OnlyOne(const OnlyOne& root) = delete;
        OnlyOne& operator=(const OnlyOne&) = delete;
};
```
3. Что такое интерфейс?

## Service-oriented architecture

## Asm
1. Что такое ассемблер? Для чего нужен?

## Linux
1. Describe how 'fork' call works?

## Linux internals

## Computer architecture

1. How virtual memory works? What is MMU?
2. What is page table? Why do we use pages?
Typically 4KB pages.
3. How many PTEs (Page Table Entries) will we need in the Page Table with 4kB pages on a 32-bit machine?

## GDB

1. b, info b
2. r
3. p
4. bt
4. up, down, frame
5. command 1


## GIT

1. Какой командой скачать репозиторий?
2. Какой командой создать локальную ветку?
3. Какой командой влить изменения из локальной ветки в master?
