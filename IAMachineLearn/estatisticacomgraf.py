import numpy as np
import scipy.stats as stats
import matplotlib.pyplot as plt
import seaborn as sns

# Conjunto de dados exato do exemplo anterior
salarios = [2500, 2700, 2800, 3000, 3200, 3500, 4000, 4200, 4500, 15000]

# Configuração estética do gráfico
plt.figure(figsize=(10, 6))
sns.set_theme(style="whitegrid")

# Criando o histograma e a linha de densidade (KDE)
sns.histplot(salarios, kde=True, bins=5, color="royalblue", edgecolor="black", alpha=0.6)

# Linhas de referência centrais
media = np.mean(salarios)
mediana = np.median(salarios)
plt.axvline(media, color="red", linestyle="--", linewidth=2, label=f"Média: R$ {media:.2f}")
plt.axvline(mediana, color="green", linestyle="-.", linewidth=2, label=f"Mediana: R$ {mediana:.2f}")

# Customização de títulos e eixos
plt.title("Visualização Estatística: Distribuição de Salários da Empresa", fontsize=14, fontweight="bold")
plt.xlabel("Salários (R$)", fontsize=12)
plt.ylabel("Frequência / Densidade", fontsize=12)

# Texto explicativo no gráfico apontando as métricas estudadas
texto_estatistico = (
    f"📊 Variância: {np.var(salarios):,.2f}\n"
    f"➡️ Skewness (Assimetria): {stats.skew(salarios):.2f}\n"
    f"📈 Kurtosis (Curtose): {stats.kurtosis(salarios):.2f}\n"
    f"💡 Entropia Contida: Baixa (Alta concentração na base)"
)
plt.gca().text(0.55, 0.4, texto_estatistico, transform=plt.gca().transAxes,
            bbox=dict(facecolor='white', alpha=0.8, edgecolor='gray', boxstyle='round,pad=1'),
            fontsize=11)

# Destacar o Outlier (CEO) que distorce os dados
plt.annotate('Outlier (CEO)\nPuxa a cauda e a média', xy=(15000, 0.5), xytext=(11000, 1.5),
             arrowprops=dict(facecolor='black', shrink=0.08, width=1, headwidth=6))

plt.legend(loc="upper right")
plt.tight_layout()

# Exibir o gráfico na tela
plt.show()


