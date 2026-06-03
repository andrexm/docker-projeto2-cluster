# Cluster Docker Swarm Automatizado com Vagrant

Este projeto é um laboratório prático para provisionamento automatizado de um cluster **Docker Swarm** utilizando **Vagrant** e **VirtualBox** como provedor de infraestrutura. 

O projeto original foi proposto pelo instrutor Denilson Bonatti, e esta versão foi otimizada para aplicar conceitos avançados de Infraestrutura como Código (IaC) e automação total (*Zero Touch Provisioning*), eliminando a necessidade de configurações manuais entre os nós.

---

## 🏗️ Arquitetura do Cluster

O ambiente é composto por 4 máquinas virtuais Ubuntu 22.04 LTS distribuídas da seguinte forma:

| Nome da VM | Papel no Swarm | IP Privado | Recursos (Mínimo) |
| :--- | :--- | :--- | :--- |
| `master` | Manager | `10.10.10.100` | 1 CPU / 1GB RAM |
| `node01` | Worker  | `10.10.10.101` | 1 CPU / 1GB RAM |
| `node02` | Worker  | `10.10.10.102` | 1 CPU / 1GB RAM |
| `node03` | Worker  | `10.10.10.103` | 1 CPU / 1GB RAM |

---

## 🚀 Melhorias Implementadas Nesta Versão

1. **Centralização de Configurações (`base_setup`):** Uso de um Hash/Dicionário no topo do `Vagrantfile` para isolar variáveis globais (recursos de hardware e imagem do SO), facilitando a manutenção do código.
2. **Automação de Join via Pasta Compartilhada (`/vagrant`):** O nó `master` inicializa o Swarm e exporta o token de autenticação diretamente para a pasta compartilhada. Os nós `worker` aguardam a geração desse arquivo e realizam o *join* automaticamente.
3. **Escalabilidade Dinâmica:** O provisionamento dos Workers foi reestruturado utilizando loops nativos em Ruby, permitindo aumentar ou diminuir o número de nós do cluster alterando apenas um caractere no loop.
4. **Clean Code:** Consolidação dos scripts de provisionamento. O arquivo genérico `docker.sh` foi descontinuado, e a instalação do motor do Docker foi acoplada diretamente ao ciclo de vida de inicialização de cada papel (`master.sh` e `worker.sh`).

---

## 🛠️ Como Executar o Projeto

### Pré-requisitos
* [Vagrant](https://www.vagrantup.com/) instalado.
* [VirtualBox](https://www.virtualbox.org/) instalado.
* Um cliente SSH (nativo no Linux/MacOS, ou Git Bash/PowerShell no Windows).

### Passo a Passo

1. Clone o seu fork do repositório:
```bash
   git clone https://github.com/SEU_USUARIO/docker-projeto2-cluster.git
   cd docker-projeto2-cluster
```

2. Inicialize o cluster com o Vagrant:
```bash
   vagrant up
```

O Vagrant irá baixar a imagem do Ubuntu, criar as 4 VMs, instalar o Docker em todas elas, iniciar o Swarm no Master e conectar os 3 Workers de forma 100% automatizada.

3. Acesse o nó Master para verificar o status do cluster:
```bash
   vagrant ssh master
   sudo docker node ls
```