defmodule PortalWeb.Live.Reports do
  use Phoenix.Component

  import GenUi.Icon

  def reports(assigns) do
    ~H"""
    <div class="card w-full p-6 bg-base-100 shadow-xl mt-2">
      <div class="text-xl font-semibold inline-block">
          Rapporter
          <div class="inline-block float-right">
            <div class="inline-block float-right">
              <button class="btn px-6 btn-sm normal-case btn-primary">
                Skapa ny rapport
              </button>
            </div>
          </div>
      </div>
      <div class="divider mt-2"></div>
      <div class="h-full w-full pb-6 bg-base-100">
          <div class="overflow-x-auto w-full">
            <table class="table w-full">
                <thead>
                  <tr>
                    <th>Namn</th>
                    <th>Beskrivning</th>
                    <th>Tags</th>
                    <th>Skapad</th>
                    <th>Senast uppdaterade</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td>
                      <div class="font-bold">
                        <.icon
                          name="hero-document"
                          class="w-5 h-5"/>
                        Rapport Kvartal 1 - 2025
                      </div>
                    </td>
                    <td>Kvartal 1, slutrapport klar</td>
                    <td>
                      <div class="badge badge-primary">Klar</div>
                      <div class="badge badge-success">Godkänd</div>
                    </td>
                    <td>22 Jul 2025</td>
                    <td>5 hr ago</td>
                  </tr>
                  <tr>
                    <td>
                      <div class="font-bold">
                        <.icon
                          name="hero-document-chart-bar"
                          class="w-5 h-5"/>
                        Urval 2026
                      </div>
                    </td>
                    <td>Rapport med metoden för urval 2026</td>
                    <td>
                      <div class="badge badge-secondary">Draft</div>
                    </td>
                    <td>17 Jul 2025</td>
                    <td>15 min ago</td>
                  </tr>
                </tbody>
            </table>
          </div>
      </div>
    </div>
    """
  end
end
