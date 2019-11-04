# DNCS-LAB

This repository contains the Vagrant files required to run the virtual lab environment used in the DNCS course.
```


        +-----------------------------------------------------+
        |                                                     |
        |                                                     |eth0
        +--+--+                +------------+             +------------+
        |     |                |            |             |            |
        |     |            eth0|            |eth2     eth2|            |
        |     +----------------+  router-1  +-------------+  router-2  |
        |     |                |            |             |            |
        |     |                |            |             |            |
        |  M  |                +------------+             +------------+
        |  A  |                      |eth1                       |eth1
        |  N  |                      |                           |
        |  A  |                      |                           |eth1
        |  G  |                      |                     +-----+----+
        |  E  |                      |eth1                 |          |
        |  M  |            +-------------------+           |          |
        |  E  |        eth0|                   |           |  host-c  |
        |  N  +------------+      SWITCH       |           |          |
        |  T  |            |                   |           |          |
        |     |            +-------------------+           +----------+
        |  V  |               |eth2         |eth3                |eth0
        |  A  |               |             |                    |
        |  G  |               |             |                    |
        |  R  |               |eth1         |eth1                |
        |  A  |        +----------+     +----------+             |
        |  N  |        |          |     |          |             |
        |  T  |    eth0|          |     |          |             |
        |     +--------+  host-a  |     |  host-b  |             |
        |     |        |          |     |          |             |
        |     |        |          |     |          |             |
        ++-+--+        +----------+     +----------+             |
        | |                              |eth0                   |
        | |                              |                       |
        | +------------------------------+                       |
        |                                                        |
        |                                                        |
        +--------------------------------------------------------+



```

# Requirements
 - Python 3
 - 10GB disk storage
 - 2GB free RAM
 - Virtualbox
 - Vagrant (https://www.vagrantup.com)
 - Internet

# How-to
 - Install Virtualbox and Vagrant
 - Clone this repository
`git clone https://github.com/dustnic/dncs-lab`
 - You should be able to launch the lab from within the cloned repo folder.
```
cd dncs-lab
[~/dncs-lab] vagrant up
```
Once you launch the vagrant script, it may take a while for the entire topology to become available.
 - Verify the status of the 4 VMs
 ```
 [dncs-lab]$ vagrant status                                                                                                                                                                
Current machine states:

router                    running (virtualbox)
switch                    running (virtualbox)
host-a                    running (virtualbox)
host-b                    running (virtualbox)
```
- Once all the VMs are running verify you can log into all of them:
`vagrant ssh router`
`vagrant ssh switch`
`vagrant ssh host-a`
`vagrant ssh host-b`
`vagrant ssh host-c`

# Assignment
This section describes the assignment, its requirements and the tasks the student has to complete.
The assignment consists in a simple piece of design work that students have to carry out to satisfy the requirements described below.
The assignment deliverable consists of a Github repository containing:
- the code necessary for the infrastructure to be replicated and instantiated
- an updated README.md file where design decisions and experimental results are illustrated
- an updated answers.yml file containing the details of 

## Design Requirements
- Hosts 1-a and 1-b are in two subnets (*Hosts-A* and *Hosts-B*) that must be able to scale up to respectively 195 and 142 usable addresses
- Host 2-c is in a subnet (*Hub*) that needs to accommodate up to 261 usable addresses
- Host 2-c must run a docker image (dustnic82/nginx-test) which implements a web-server that must be reachable from Host-1-a and Host-1-b
- No dynamic routing can be used
- Routes must be as generic as possible
- The lab setup must be portable and executed just by launching the `vagrant up` command

## Tasks
- Fork the Github repository: https://github.com/dustnic/dncs-lab
- Clone the repository
- Run the initiator script (dncs-init). The script generates a custom `answers.yml` file and updates the Readme.md file with specific details automatically generated by the script itself.
  This can be done just once in case the work is being carried out by a group of (<=2) engineers, using the name of the 'squad lead'. 
- Implement the design by integrating the necessary commands into the VM startup scripts (create more if necessary)
- Modify the Vagrantfile (if necessary)
- Document the design by expanding this readme file
- Fill the `answers.yml` file where required (make sure that is committed and pushed to your repository)
- Commit the changes and push to your own repository
- Notify the examiner that work is complete specifying the Github repository, First Name, Last Name and Matriculation number. This needs to happen at least 7 days prior an exam registration date.

# Notes and References
- https://rogerdudler.github.io/git-guide/
- http://therandomsecurityguy.com/openvswitch-cheat-sheet/
- https://www.cyberciti.biz/faq/howto-linux-configuring-default-route-with-ipcommand/
- https://www.vagrantup.com/intro/getting-started/


# Design
[ Your work goes here ]

Name: Simone
Surname: Luchetta 
ID Number: 193445

Explanation of the design characteristics for the task assigned by Nicola Arnoldi.

# Step 1) Preparing the project:
For this step, we were required to run the pyhton3 script named "dncs-init", and compile it with our personal informations.
Basically, what this little script was supposed to do was to create the subnetworks sizes, which we would need to further develop correctly our Vagrant file, hence all the .sh files afterwards (containing the matched subnet lenghts and so on).
In my case, the script generated the following sizes for me:
        - HostA: 195 Hosts.
        - HostB: 142 Hosts.
        - HostC: 261 Hosts.
After this was done, I renamed a couple of things in the vagrant file to match the existing files that I created in the project folder, so that when I would have launched the "vagrant up" command afterwards, the initialisation process would have picked my setups contained in those files.

# Step 2) Planning the IPs:
Once I have been given all the informations needed, I would have proceeded this way: first, I would have picked a commercial IP address (i.g. 127.16.0.0), and then I would have calculated how much space I needed the networks to occupy.

Starting with the hostA network, I would have needed to include a total amount of space of 195 hosts. That would have meant that I could have picked a /24 lenght subnet (the reason why, is because I would have obtained 32-24 = 8 --> 2^8 = 255 Hosts guaranteed).
I decided to allocate the space for hostA this way:
HOST_A --> 127.16.0.0/24

I adopted the same strategy for the hostB, since the requirement was to host up to 142 different kind of hosts.
So, I once again decided to allocate the space for hostB as follows:
HOST_B --> 127.16.1.0/24

Differently, hostC network needed a bit more of space since it needed to occupy up to 261 different hosts, so I opted for a /23 instead of a /24 network lenght (this due to the fact that 32-23 = 9, 2^9 = 512 different hosts).
So, the hostCs were allocated as follows:
HOST_C --> 127.16.2.0/23

# Step 3) setting up the routes:
So, now that I have all the subnet lenghts matched to the task requirements, what is left for me to do?
Of course, I need to set up the routes in order to create the correct net topology as shown upper in this readme file.
But how could I manage this? Well, one thing that came to my mind was to search a list of Debian-Linux commands, so that once I got the syntax I would have applied it to recreate correctly the net topology.
I also expected that my other collegues would have written the same commands as me in their ".sh" files, and that is mainly due to the fact that there are no alternatives: we all are stuck to:
        - ip link
        - ip addr
        - ip route
At least, I hope I written them consistently as what I specified for my networks:

        - hostA: 172.16.0.21 --> ETH1
        - hostB: 172.16.1.22 --> ETH1
        - hostC: 172.16.2.23 --> ETH1

        - router1: 172.16.4.1/30 --> ETH2
        - router1: 172.16.0.1/24 --> ETH1.7
        - router1: 172.16.1.1/24 --> ETH1.8

        - router2: 172.16.4.2/30 --> ETH2
        - router2: 172.16.2.1/23 --> ETH1

In my case, since the networks for hostA and hostB had the same lenght (/24), I could have written the command in the router2 setup:
" ip route add 172.16.0.0/23 ", so that when some C wants to talk to A or B, it gets directed to somewhere that recalls the sum of both networks: 172.16.0.0/24 + 172.16.1.0/24.
I decided no to do this, as if someday we decide to change something in either A or B, things could start to get messy.
To verify if the routes were all working, the simplest thing that comes to mind is to log in any Virtual Machine, and run the ping all command:
        " vagrant ssh host-b "
        " ping all "
Fortunately, I got all the stuff working, so I decided to proceed furthermore deep into the task.

# Step 4) Running Docker in hostC, serve hostA and hostB:
This part is where things get complicated.
I needed to read carefully the documentation on Docker's website, and I chose " NGINX " to host my simple, static HTML file.
A whole lot of documentation is available online, but this is what I decided to do:
        - Create a directory named DNCS_Lab_Simo on my host-c Virtual Machine.
        - Inside the directory, create a new file called "index.html".
        - Edit the file, inserting the content that I wanted.
        - Run the Docker , with NGINX hosting my HTML content.

To verify if everything was working fine, the last thing I needed to do was to apply the following command (being either logged in host-a or host-b):

        " sudo curl " + host-c IP-Address.
Which in my case is:
        " sudo curl 172.16.2.1 ".

If everything goes correctly then it should appear the HTML file in the terminal console of host-a or host-b.