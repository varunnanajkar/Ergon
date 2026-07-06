# Ergon
Projects 
The picture below is the waveform of an 8bit synchronous fifo.
Performing 40 writes and 60 reads
<img width="3250" height="1724" alt="image" src="https://github.com/user-attachments/assets/af43f0aa-6e63-42b2-b44b-f73e107d02db" />
Future Enhancements to this would include-


1>Improving system efficiency by adding more flags to create warnings of a full state,this way read can be enabled in time to prevent and overflow, same way write can be prepared to prevent an underflow.
An implentation of this is the FWFT{first word fall through}-where the read is enabled as soon as the first entry is made.


2>Another measure to be added for a useful debugging process would be to be aware of an overflow/underflow, This gives us an idea of the data rates and also the required memory.[catching an overflow/underflow with a timing notice]


3>Ensuring a simultaneous read/write operation to enhance throughput.



4>Creating a log of runtime during operation.


5>Asynchronous System -More pragmatic system would deal with different clock rates[i.e. read at 60Hz Writes at 120Hz]-Deals with advanced concepts such as CDCs,Sychronizers,Grey Code Crossing




