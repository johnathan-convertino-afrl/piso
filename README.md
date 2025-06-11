# PISO
### Parallel to Serial Converter Core

![image](docs/manual/img/AFRL.png)

---

  author: Jay Convertino   
  
  date: 2024.03.19
  
  details: Interface Parallel to Serial interfaces. MSb or LSb first.

  license: MIT   
   
  Actions:  

  [![Lint Status](../../actions/workflows/lint.yml/badge.svg)](../../actions)  
  [![Manual Status](../../actions/workflows/manual.yml/badge.svg)](../../actions)  
  
---

### Version
#### Current
  - V1.0.0 - change count amount to a register that can be changed at anytime.

#### Previous
  - V1.0.0 - initial release
  - none

### DOCUMENTATION
  For detailed usage information, please navigate to one of the following sources. They are the same, just in a different format.

  - [PISO.pdf](docs/manual/PISO.pdf)
  - [github page](https://johnathan-convertino-afrl.github.io/piso/)

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
  - lint
  - sim
  - sim_cocotb
