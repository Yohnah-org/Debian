# Begin

Welcome to this modest project, a Debian Desktop alternative on Vagrant by Hashicorp

Just run ***vagrant up*** command and get a worked Debian Desktop alternative

Debian GNU/Linux is used as OS based system for compatibily reasons among the listed [hypervisors](#hypervisor) below
___
***Note:***
Vagrant Cloud repository: [https://app.vagrantup.com/Yohnah/boxes/Debian](https://app.vagrantup.com/Yohnah/boxes/Debian)

Vagrant Cloud repository support the following providers: VirtualBox. If you need to get a version for other of compatible [hypervisors](#hypervisor), please see the "[Building from sources](#building-from-sources)" section for more information
___

# Requirements

## Compatible Operative Systems as host

* Windows 10/11
* MacOS (tested on BigSur x86_64 and higher)
* GNU/Linux

## Software

* Vagrant: <https://www.vagrantup.com/>

## Hypervisors

One of the following hypervisors must be installed:

* Virtualbox: <https://www.virtualbox.org/>
* Parallels: <https://www.parallels.com/> (only x86_64 compatible)
* Hyper-V: <https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/about/>
* VMWare Workstation or Fusion: <https://www.vmware.com/>

## In order to build yourself

* GNU Make: <https://www.gnu.org/software/make/>
* Packer: <https://www.packer.io/>
* jq: <https://stedolan.github.io/jq/>
* Window Subsystem LInux or CygWin if Windows is used (to run the "make" command)

# How to use

## Short prompts

Run on Unix-Like and MacOs:

~~~
$ vagrant init Yohnah/Debian #or vagrant init --box-version '<Debian version>' Yohnah/Debian
$ vagrant up #or vagrant up --provider <hypervisor>
~~~

On Windows PowerShell:

~~~
PS C:\Users\JohnDoe> vagrant.exe init Yohnah/Debian #or vagrant.exe init --box-version '<Debian version>' Yohnah/Debian
PS C:\Users\JohnDoe> vagrant.exe up #or vagrant up --provider <hypervisor>
~~~

On Windows CMD:

~~~
C:\Users\JohnDoe> vagrant.exe init Yohnah/Debian #or vagrant.exe init --box-version '<Debian version>' Yohnah/Debian
C:\Users\JohnDoe> vagrant.exe up #or vagrant up --provider <hypervisor>
~~~

Where "\<Debian version\>" is the specific version of Debian you want to use according Debian releases notes <https://www.debian.org/releases/>

Resulting a configured and worked Debian service and installed client binaries on host device to be used just like Debian Desktop does



# Building from sources

Another option to use Yohnah/Debian Box is building it from sources.

To reach it out, first of all, the code must be cloned from the git repository on GitHub:

~~~
$ git clone github.com/Yohnah-org/Debian.git
~~~

And, inside of git workspace run the following command:

## Running the GNU make command

~~~
debian/$ make build
~~~

And a local box for virtualbox provider will build.

If you want to build a box for another [Hypervisor](#hypervisor) compatible, just run the make command as follows:

~~~
debian/$ make PROVIDER=<hypervisor>
~~~

Ex:
~~~
debian/$ make PROVIDER=virtualbox #default behaviour
debian/$ make PROVIDER=hyperv
debian/$ make PROVIDER=virtualbox
debian/$ make PROVIDER=parallels
~~~

Once make was done, the box can be found at /tmp/packer-build directory

## Just Packer

On the other hand, you want to build the box just using Packer, then you have to fit the following variables in:

* output_directory to set the path where packer dump the box
* debian_version to set what version of debian must be installed
* debian_version to set the version of debian to build the virtual machine golden image for the esulting box

Also, you must use the -only param to set what provider want to use:

* builder.virtualbox-iso.debian
* builder.parallels-iso.debian
* builder.vmware-iso.debian
* builder.hyperv-iso.debian

As follows:

~~~
debian/$ packer build -var "output_directory=</path/to/dump/the/box>" -var "debian_version=<version of debian>" -only <builder to build the box> packer.pkr.hcl
~~~

Ex:
~~~
debian/$ packer build -var "output_directory=/tmp" -var "debian_version=11.2.0" -only builder.virtualbox-iso.debian packer.pkr.hcl
~~~

For getting a built virtualbox box 

## Test and use it

Once the package box is created, just import it into vagrant doing:

~~~
$ vagrant box add --name "Yohnah/Debian" /path/to/package.box
~~~

/path/to/package.box is the path where the resulting box can be found

Finally, confirm the package was imported on Vagrant:

~~~
$ vagrant box list
~~~

Thereafter, follow the steps in the [how to use](#how-to-use) section