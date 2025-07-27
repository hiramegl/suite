defmodule PortalWeb.Live.Links do
  use Phoenix.Component

  import GenUi.Icon

  def links(assigns) do
    ~H"""
    <div class="card w-full p-6 bg-base-100 shadow-xl mt-2">
      <div class="text-xl font-semibold">
        Mina länkar
        <div class="inline-block float-right">
          <div class="inline-block float-right">
            <button class="btn px-6 btn-sm normal-case btn-primary">
              Spara ny länk
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
                      <th>Id</th>
                      <th>Skapat datum</th>
                      <th>Beskrivning</th>
                      <th>Länk</th>
                      <th>Status</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                      <td>#4567</td>
                      <td>26 Jun 2025</td>
                      <td>Sök motorn</td>
                      <td>
                        <.icon
                          name="hero-link"
                          class="w-5 h-5"/>
                        <a
                          href="https://www.google.com"
                          target="_blank">
                          www.google.com
                        </a>
                      </td>
                      <td>
                        <div class="badge badge-primary">Aktiv</div>
                      </td>
                  </tr>
                  <tr>
                      <td>#4523</td>
                      <td>27 May 2025</td>
                      <td>Intranet SCB</td>
                      <td>
                        <.icon
                          name="hero-link"
                          class="w-5 h-5"/>
                        <a
                          href="https://intra.scb.se"
                          target="_blank">
                          intra.scb.se
                        </a>
                      </td>
                      <td>
                        <div class="badge badge-primary">Aktiv</div>
                      </td>
                  </tr>
                  <tr>
                      <td>#4453</td>
                      <td>27 Apr 2025</td>
                      <td>Huvudsida for rapporter</td>
                      <td>
                        <.icon
                          name="hero-link"
                          class="w-5 h-5"/>
                        <a
                          href="https://intra.scb.se/aku"
                          target="_blank">
                          AKU huvudsida
                        </a>
                      </td>
                      <td>
                        <div class="badge badge-success">Uppdateras</div>
                      </td>
                  </tr>
                  <tr>
                      <td>#4359</td>
                      <td>28 Mar 2025</td>
                      <td>Huvudsida for rapporter</td>
                      <td>
                        <.icon
                          name="hero-link"
                          class="w-5 h-5"/>
                        <a
                          href="https://intra.scb.se/ulf"
                          target="_blank">
                          ULF huvudsida
                        </a>
                      </td>
                      <td>
                        <div class="badge badge-success">Uppdateras</div>
                      </td>
                  </tr>
                </tbody>
            </table>
          </div>
      </div>
    </div>
    """
  end
end
