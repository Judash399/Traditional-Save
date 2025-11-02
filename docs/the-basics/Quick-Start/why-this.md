# Why this?

You may be asking yourself:

> "Why use this over any other data-store module."

And that is a perfectly understandable question to have, and props to your for sticking around long enough to check the documentation. This entire page is a bunch of me just writing whatever comes to head about TraditionalSave1's issue, and I will not be offended if you skip over this. But the main reason to use this is because it simplifys the process of save data, and trys at a new way of managing save data.

Ok, the rest of this is my writing whatever. So lets start on TraditionalSave1's problem:

## The problem
TraditionalSave2 is a save data module for roblox that proposes a new way of storing and interacting with player save data. The methods *TraditionalSave2* makes many improvments from *TraditionalSave* enough where It is a very unique, elegant, and distinct way from interacting with player data.

Instaid of having all your data combined into 1 big blob of save data, TraditionalSave proposed that your seperate your data into different "files" originaly to help with more "Traditional" developers create save files. Unfortunatly TraditionalSave1's sollution to doing things had many issues, as I realized from using it in my own projects:

> "You are going to end up having data that is globably needed. But TraditionalSave1 only lets you have **1** thing loaded at a time."

Unfortunatly, I couldn't simply just fix this issue, it was ingrained deeply into module inner workings and exactly how you do things.

I thought of solutions like "side loading", but none of my ideas seemed elegant enough to implement directly into the module.

Because TraditionalSave1 was such a mess of a codebase so it was really hard to add anything to it, so any of my ideas I couldn't really implement.

Because of my issues with TraditionalSave 1, I was pretty much stuck on this problem, so just let it sit around not being solved.

## The solution.

Eventually, one day I thought of an idea:

> "What If you could just load as many things as you want?"

Then I procceeded to come up with the concept of loaders. You attach loaders to a profile, and they can store 1 file just like the original. This immediatly fixes all issues with the previous version, by taking some control away from Profiles, and giving it to loaders. All of a sudden, a lot of restrictions were cleared up. So then I started development on TraditionalSave2, which is a complete rewrite from the orignal, while making many, many improvments from the original module.

Along the way of doing the rewrite I kept of coming up with ideas of things to add, to make it "Just work", My hope is that it has a decent quantity of features that make most things related to save data be simple and elegant to setup. And, TraditionalSave2 will be continued to maintained with more features. At the time of writing this, TraditionalSave2 has not been used in a production setting, *yet*. I do plan to use TraditionalSave2 in my current project *Blockwoode Theatre* and hopefully my future projects.

Thanks for sticking around and reading this, the grammar probably sucks lol.