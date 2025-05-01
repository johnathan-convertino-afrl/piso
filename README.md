# PISO
### Parallel to Serial Converter Core

![image](docs/manual/img/AFRL.png)

---

   author: Jay Convertino   
   
   date: 2024.03.19
   
   details: Interface Parallel to Serial interfaces. MSb or LSb first.

   license: MIT   
   
---

### Version
#### Current
  - V1.0.0 - initial release

#### Previous
  - none

### DOCUMENTATION
  For detailed usage information, please navigate to one of the following sources. They are the same, just in a different format.

  - [PISO.pdf](docs/manual/PISO.pdf)
  - [github page](https://johnathan-convertino-afrl.github.io/piso/)

### DEPENDENCIES
#### Build

  - AFRL:utility:helper:1.0.0
  
#### Simulation

  - icarus
  - cocotb

### PARAMETERS

* BUS_WIDTH     : Bus width in number of bytes.

### COMPONENTS
#### SRC

* piso.v

#### TB

* tb_piso.v
* tb_cocotb.py
* tb_cocotb.v
  
### FUSESOC

* fusesoc_info.core created.
* Simulation uses icarus to run data through the core.

#### Targets

* RUN WITH: (fusesoc run --target=sim VENDER:CORE:NAME:VERSION)
  - default (for IP integration builds)
  - sim
  - sim_cocotb
